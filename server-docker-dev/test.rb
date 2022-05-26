require 'mongo'

client = Mongo::Client.new(['localhost'], database: 'test')

client['foo'].indexes.create_one(test: 1)
client.with(write_concern: {w: 40})['foo'].indexes.drop_one(test: 1)

p 'done'
