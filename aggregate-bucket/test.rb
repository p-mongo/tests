require 'mongo'

Mongo::Logger.logger.level = Logger::WARN

client = Mongo::Client.new(['localhost:14420'])
c = client['foo']

=begin

c.delete_many

10.times do |i|
  day_time = Time.now - i*86400
  100.times do |j|
    time = day_time + j*100
    count = rand*1000
    message = "message #{count}"

    c.insert_one(time: time, count: count, message: message)
  end
end

=end

days = (-1..10).map { |i| Time.now - i*86400 }.reverse
pp c.aggregate([
  {'$sort' => {count: -1}},
  {'$bucket' => {groupBy: '$time', boundaries: days,
    output: {messages: {'$push' => '$$ROOT'}},
  }},
  {'$project' => {top_messages: {'$slice' => ['$messages', 5]}}},
]).to_a
