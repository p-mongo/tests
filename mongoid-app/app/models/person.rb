class Person
  include Mongoid::Document
  field :ssn

  shard_key ssn: 1
  index ssn: 1 # the collection must have an index that starts with the shard key

  store_in collection: 'foo'
end
