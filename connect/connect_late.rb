# This test is for driver discovering and connecting to primary
# outside of the constructor.
#
# Initially the server at 27017 should not be running.
# Initial connection by Mongo::Client should fail.
# Then start the server.
# The client should notice that the server came up and connect to it.
#
# localhost:27018, localhost:27019 as started by e.g.
# mlaunch --replset.
# The test is for hostname/IP mismatch in seed address given to client.

require 'mongo'

MONGODB_URI = 'mongodb://127.0.0.1:27017/'

client = Mongo::Client.new(MONGODB_URI)

start = Time.now

while true
  puts client.inspect_verbose
  #puts client.inspect
  begin
    client.database['test'].insert_one({a:1})
    puts "Success"
  rescue => e
    puts "Error: #{e}"
  end

  sleep 1
end
