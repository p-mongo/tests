require 'mongo'

client = Mongo::Client.new(['127.0.0.1:27741']).use('foo')

coll = client['test-collection']
p coll.find.first
