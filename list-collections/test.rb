require 'byebug'
require 'mongo'

client = Mongo::Client.new('mongodb+srv://demo:demo@apisentris-demo-thikk.gcp.mongodb.net', database: 'demo')



# client.database.list_collections

byebug

p client.database.command(listCollections: 1).documents
