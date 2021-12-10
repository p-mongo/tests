require 'mongo'

client = Mongo::Client.new([ 'mongodb:27017' ], database: 'training')

collection = client[:customers]

puts collection.find(name: 'Dominic Thomas').first
