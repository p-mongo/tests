require 'mongo'

client = Mongo::Client.new(['127.0.0.1:27741']).use('foo')

coll = client['test-collection']
coll.insert_one(b: 2)

session = client.start_session
session.start_transaction
coll.insert_one({a: 1}, session: session)

#session.abort_transaction
#session.end_session

# A client session references a server session.
# Closing a client does not end server session, and as a result
# the server session remains alive up to transaction timeout (?)
# and blocks subsequent operations on the collection
client.close

client2 = Mongo::Client.new(['127.0.0.1:27741']).use('foo')
coll2 = client['test-collection']

coll2.database.drop
