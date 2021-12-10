require 'mongo'

client = Mongo::Client.new([ 'mongodb:27017' ], database: 'training')

collection = client[:customers]

doc = {name: "Tony Sansone", age: 49, emails: ["tony@mongodb.com", "a.t.sansone@gmail.com"], last_login: "2021-12-08T00:15:00.000Z"}

result = collection.insert_one(doc)

puts "You have added #{result.n} record.\n\n"

puts "Your new record is:\n #{collection.find(name: 'Tony Sansone').first}"
