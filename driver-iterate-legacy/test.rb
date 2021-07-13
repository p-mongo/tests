require 'mongo'

a = Mongo::Client.new(['localhost:12600'])

a['foo'].delete_many
5.times do |i|
  a['foo'].insert_one(test: i)
end

enum = a['foo'].find({}, batch_size: 1).to_enum

5.times do
  p enum.next
end
