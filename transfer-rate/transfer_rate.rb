require 'benchmark'
require 'mongo'

Mongo::Logger.level = Logger::INFO

iter_count = (ENV['ITER_COUNT'] || 300).to_i

puts "Connecting..."
client = Mongo::Client.new(
  ENV['MONGODB_URI'] || [ '127.0.0.1:27017' ],
  database: 'test',
)

collection = client[:test]

puts "Warming up..."
collection.delete_many
(iter_count/5).times do |i|
  collection.insert_one(i: i, data: 'x' * (1000000 + i))
end

puts "Benchmarking write..."
time = Benchmark.realtime do
  iter_count.times do |i|
    collection.insert_one(i: i, data: 'y' * (15000000 + i))
  end
end

puts "%.2f inserts/second" % (iter_count.to_f / time)

collection.indexes.create_one(i: 1)

def bench_read(collection, iter_count)
  puts "Warming up..."
  (iter_count/5).times do |i|
    collection.find(i: i).to_a
  end

  puts "Benchmarking read..."
  time = Benchmark.realtime do
    iter_count.times do |i|
      collection.find(i: i).to_a
    end
  end

  puts "%.2f reads/second" % (iter_count.to_f / time)
end

bench_read(collection, iter_count)

require 'mongoid'

bench_read(collection, iter_count)
