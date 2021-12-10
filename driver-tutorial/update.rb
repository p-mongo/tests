require 'mongo'

client = Mongo::Client.new([ 'mongodb:27017' ], database: 'training')

collection = client[:customers]

result = collection.update_one({name: 'Tony Sansone'}, '$set' => {name: 'Anthony T. Sansone'})

puts "You have changed #{result.modified_count} record.\n\n"

puts "Your updated record is:\n #{collection.find(name: 'Anthony T. Sansone').first}"
