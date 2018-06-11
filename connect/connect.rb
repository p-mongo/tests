require 'mongo'

MONGODB_URI = 'mongodb://127.0.0.1:27017'

client = Mongo::Client.new(MONGODB_URI)

puts client.inspect_verbose
#puts client.inspect
p client.database['test'].insert_one({a:1})
