## Mongoid & Sessions

### Global Configuration (Proposed)

    development:
      clients:
        default:
          database: mongoid
          hosts:
            - localhost:27017
          options:
            # Enables retryable writes
            retry_writes: true
            # Enables causal consistency
            causal_consistency: true

Note that retry_writes and causal_consistency options are inconsistently named
in that the first one is a verb and the second one is a noun.
However, retryWrites is an option mentioned in
https://docs.mongodb.com/manual/core/retryable-writes/#retryable-writes
and both retry_writes and causal_consistency are existing options in Ruby driver.

If either retry_writes or causal_consistency are set, a session is
implicitly created by Mongoid around all operations. Attempting to
start a session via `Model#with_session` raises an exception.

### Explicit Session Management

This is the current behavior.

If the global configuration proposal above is adopted, in order to manage
sessions explicitly both retry_writes and causal_consistency global options
must not be set.

    User.with_session do
      User.create!(name: 'John T')
      
      # finds the user that was just created, potentially from a secondary
      User.where(name: 'John T').first
    end

`with_session` calls cannot be nested:

    User.with_session(causal_consistency: true) do
    
      # elsewhere in application
      User.with_session(causal_consistency: true) do # raises Mongoid::Errors::InvalidSessionUse
      
        # ...
        
      end
    end

Lack of nesting ability makes explicit sessions non-composable, and therefore
limited to specialized use cases.

Note that the only option that appears to be defined presently is
`causal_consistency`. Retryable writes are turned on/off on the client level
and are not a session option. Transactions are also not a session option.

## Mongoid & Transactions

### API (Proposed)

    User.transaction do
      user = User.create!(name: 'John T')
      Post.create!(user: user, title: 'Hello')
    end

`transaction` call creates a session if one is not already active.
If a session is thus created, it is ended when the `transaction` block ends.

This means `with_session` cannot be nested under `transaction calls`.

To obtain retryable writes or causal consistency, application should configure
sessions globally as proposed above (but note that Ruby driver implements
"legacy retryable writes" which do not need or use a session, which
an application may utilize even when in a transaction).

### Transaction Nesting (Proposed)

`transaction` calls may be nested. Nested calls are effectively no-ops;
all operations are performed within the context of the outermost transaction.

    # controller level or Rack middleware
    User.transaction do
      user = User.create!(name: 'John T')
      Post.create!(user: user, title: 'Hello')
      
      # elsewhere in the application or in a component
      Payment.transaction do
        Payment.create!(user: user, description: "...")
        Entitlement.create!(user: user, target: ...)
      end
    end

Nested transactions maintain the semantics of all operations under them
persisting to the database together or not at all.

### Explicit Transaction Management

This is existing behavior.

    User.with_session do |session|
      session.start_transaction
      
      User.create!(name: 'John T')
      
      # commit can be manually retried by the application at this point
      session.commit_transaction
    end

Neither sessions nor transactions may be nested when managing transactions
explicitly like this, making explicit transaction management non-composable
and practical only for short sequences of code.
