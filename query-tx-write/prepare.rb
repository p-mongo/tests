require 'mongo'

client = Mongo::Client.new(['localhost:14420'], database: 'foo')

coll = client['coll']

coll.delete_many
coll.insert_many([foo: 1]*10000)
