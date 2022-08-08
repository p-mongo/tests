require 'mongo'

#Mongo::Logger.logger.level = 0

client = Mongo::Client.new(['localhost:14400'])
coll = client['foo']

3_000.times do |i|
  docs = 1000.times.map do |j|
    {i: i, j: j}
  end
  coll.insert_many(docs)
end
