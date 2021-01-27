require 'mongo'

client = Mongo::Client.new(['localhost:14400'])

coll = client['coll']

coll.delete_many
coll.insert_one(foo: 1)

rv = coll.update_one({foo: 1}, '$set' => {foo: 2})
if rv.modified_count == 1
  puts 'Updated'
end

rv = coll.update_one({foo: 1}, '$set' => {foo: 2})
if rv.modified_count == 1
  puts 'Updated'
end
