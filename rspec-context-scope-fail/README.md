    serene% rspec fail_spec.rb
    F

    Failures:

      1) fail A example
         Failure/Error: expect(persisted_person).to eq("one")
         
           expected: "one"
                got: "two"
         
           (compared using ==)
         Shared Example Group: "shared" called from ./fail_spec.rb:13
         # ./fail_spec.rb:6:in `block (3 levels) in <top (required)>'

    Finished in 0.01613 seconds (files took 0.10724 seconds to load)
    1 example, 1 failure

    Failed examples:

    rspec ./fail_spec.rb:5 # fail A example

