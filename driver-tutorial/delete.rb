require 'mongo'

client = Mongo::Client.new([ 'mongodb:27017' ], database: 'training')

collection = client[:customers]

result = collection.find(name: 'Anthony T. Sansone').delete_one

puts "You have removed #{result.deleted_count} record."
