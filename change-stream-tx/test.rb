require 'mongo'

Mongo::Logger.logger.level = Logger::INFO

client = Mongo::Client.new(['localhost:14420'], database: 'f')

coll = client['foo']
cs = coll.watch

client.start_session do |s|
  s.with_transaction do
    coll.insert_one({a: 1}, session: s)
    coll.insert_one({a: 2}, session: s)
  end
end

coll.insert_one(a: 3)

enum = cs.to_enum
3.times do
  p enum.next
end
