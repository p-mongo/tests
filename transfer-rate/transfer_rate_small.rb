require 'benchmark'
require 'mongo'

# This benchmark measures (network) performance of Ruby driver when performing
# many small reads.
#
# This is accomplished by reading many (10,000 by default) tiny documents
# setting batch size to 1.
# Other batch sizes can be set to obtain read performance vs batch size.
#
# The second read benchmark simulates a real application with many
# classes/modules defined in the object space. This significantly slows down
# memory allocations.

Mongo::Logger.level = Logger::INFO

iter_count = (ENV['ITER_COUNT'] || 30).to_i
data_size = (ENV['DATA_SIZE'] || 10_000).to_i
batch_size = (ENV['BATCH_SIZE'] || 1).to_i

puts "Connecting..."
client = Mongo::Client.new(
  ENV['MONGODB_URI'] || [ '127.0.0.1:27017' ],
  database: 'test',
  ssl_verify: false,
)

collection = client[:test]

puts "Adding data..."
collection.delete_many
data_size.times do |d|
  collection.insert_one(i: d, data: d)
end

collection.indexes.create_one(i: 1)

def bench_read(collection, iter_count, data_size, batch_size)
  puts "Warming up..."
  (iter_count/5).times do |i|
    collection.find({}, batch_size: batch_size).to_a
  end

  puts "Benchmarking read..."
  time = Benchmark.realtime do
    iter_count.times do |i|
      collection.find({}, batch_size: batch_size).to_a
    end
  end

  puts "%.2f reads/second of #{data_size} documents" % (iter_count.to_f / time)
end

bench_read(collection, iter_count, data_size, batch_size)

require 'mongoid'
require_relative '../ssl-perf/load'
load(1000)
GC.start

bench_read(collection, iter_count, data_size, batch_size)
