# This test is meant to have a replica set configured at localhost:27017,
# localhost:27018, localhost:27019 as started by e.g.
# mlaunch --replset.
# The test is for hostname/IP mismatch in seed address given to client.

require 'mongo'

MONGODB_URI = 'mongodb://127.0.0.1:27017/'

client = Mongo::Client.new(MONGODB_URI)

if client.respond_to?(:inspect_verbose)
  puts client.inspect_verbose
else
  puts client.inspect
end

p client.database['test'].insert_one({a:1})

if client.respond_to?(:inspect_verbose)
  puts client.inspect_verbose
else
  puts client.inspect
end
