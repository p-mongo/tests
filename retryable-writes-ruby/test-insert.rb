require 'mongo'

uri = "mongodb://localhost:14070,localhost:14071/"

client = Mongo::Client.new(uri)

client['foo'].insert_one(a: 1)
