require 'mongo'

client = Mongo::Client.new(['localhost:14420'], database: 'test')
coll = client['bench']
coll.drop
coll.insert_many([{foo: 1}] * 500_000)

loop do
  coll.update_many({}, '$inc' => {counter: 1})
end
