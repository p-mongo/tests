require 'mongo'

client = Mongo::Client.new(['localhost:14440'], database: 'foo')

client['foo'].insert_one(a: 1)
read_client = client#.with(read: {mode: :secondary})
10.times do
  p read_client['foo'].find.first
end
