require 'mongo'

client = Mongo::Client.new(['localhost:14440'], database: 'foo')

client['foo'].insert_one(a: 1)
read_client = client.with(read: {mode: :secondary_preferred})
read_client.cluster.next_primary.with_connection do |c|
  msg = Mongo::Protocol::Query.new('test', 'test', {})
  p c
end
