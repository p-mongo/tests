require 'mongo'

client = Mongo::Client.new(['localhost:14420'], database: 'test')
coll = client['bench']
coll.drop

loop do
  coll.insert_many([{foo: 1}] * 100_000)
end
