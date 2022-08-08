require 'pp'
require 'benchmark'
require 'mongo'

Mongo::Logger.logger.level = 0

client = Mongo::Client.new(['localhost:14400'])
coll = client['foo']

p(Benchmark.realtime do
  coll.count
end)

p(Benchmark.realtime do
  coll.estimated_document_count
end)

p(Benchmark.realtime do
  coll.count_documents
end)

q1 = [{"$match"=>{}}, {"$group"=>{"_id"=>1, "n"=>{"$sum"=>1}}}]

  pp coll.aggregate(q1).explain

q1 = [{"$match"=>{}}, {"$group"=>{"_id"=>nil, "n"=>{"$sum"=>1}}}]

  pp coll.aggregate(q1).explain

p(Benchmark.realtime do
  coll.aggregate(q1).to_a
end)

q2 = [{ '$sort': {_id: 1 }}, {"$group"=>{"_id"=>nil, "n"=>{"$sum"=>1}}}]

  pp coll.aggregate(q2).explain

p(Benchmark.realtime do
  coll.aggregate(q2).to_a
end)
