require 'mongo'

client = Mongo::Client.new(['localhost:14420'], database: 'foo')

coll = client['coll']

v = coll.find.first['foo']
client.start_session do |s|
  s.with_transaction do
    coll.insert_many([foo: v+1]*10000, session: s)
    coll.delete_many({foo: v}, session: s)
  end
end
