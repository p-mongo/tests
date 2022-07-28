require 'byebug'
require 'mongo'

Mongo::Logger.logger.level = 0

client = Mongo::Client.new(['localhost:14400'])

coll = client['foo']
coll.delete_many

coll.insert_many(100.times.map { |i| {a: i} })

view = coll.find.batch_size(5)

p view.first
# => 0
p view.first
# => 0

view.to_enum.next
view.to_enum.next

e1 = view.to_enum
p e1.next

e2 = view.to_enum

6.times { p e1.next }
# 0..4
p view.cursor

puts

6.times { p e2.next }
# 0..4
p view.cursor

puts
puts 'e1 again'

6.times { p e1.next }
# 0..4

puts
puts 'e2 again'

6.times { p e2.next }
# 0..4

p view.first
