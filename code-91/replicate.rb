require 'mongo'
require 'securerandom'

client = Mongo::Client.new('mongodb://localhost:27300/foo')

collection = client[SecureRandom.uuid]

1.times { collection.insert_one({code: 91}) }
$a=1
puts collection.find.sort({"_id": 1}).to_a.length

200.times { |i|
  collection.insert_one({foo: 'bar'})
  puts collection.find.sort({"_id": 1}).to_a.length
}
