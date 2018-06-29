require 'benchmark'
require 'mongo'

# This benchmark measures (network) performance of Ruby driver when reading
# large and small documents, with and without SSL.
#
# For large documents test we create 15 mb documents and read them
# one at a time.
#
# For small document test we insert 10,000 tiny documents into a collection
# and iterate the entire collection with batch size=1 which issues a getMore
# for each document.
#
# Then we apply a load by loading a bunch of classes and repeat the benchmarks.
# This simulates a real-ish Rails app which has a bunch of model etc. classes
# in it, specifically once there is a large number of classes/modules in the
# object space memory allocations get significantly slower.
#
# Everything above is done twice: once without SSL and once with SSL.

Mongo::Logger.level = Logger::INFO

class Bench
  def initialize(mongodb_uri=nil)
    @mongodb_uri = mongodb_uri || ENV['MONGODB_URI'] || [ '127.0.0.1:27017' ]
  end

  def large_iter_count
    @large_iter_count ||= (ENV['LARGE_ITER_COUNT'] || 200).to_i
  end

  def small_iter_count
    @small_iter_count ||= (ENV['SMALL_ITER_COUNT'] || 30).to_i
  end

  def small_data_size
    @small_data_size ||= (ENV['SMALL_DATA_SIZE'] || 10_000).to_i
  end

  def small_batch_size
    @small_batch_size ||= (ENV['SMALL_BATCH_SIZE'] || 1).to_i
  end

  def client
    @client ||= begin
      puts "Connecting..."
      client = Mongo::Client.new(
        @mongodb_uri,
        database: 'test',
        ssl_verify: false,
      )
      client.command(ismaster: 1)
      server_version = client.command(buildInfo:1).documents.first['version']
      puts "Connected to server #{server_version}"
      client
    end
  end

  def large_collection
    @large_collection ||= client[:test_large]
  end

  def small_collection
    @small_collection ||= client[:test_small]
  end

  def prepare_small
    puts "Inserting small test data..."
    small_collection.delete_many
    puts "Small test data"
    small_data_size.times do |d|
      small_collection.insert_one(i: d, data: d)
    end
    small_collection.indexes.create_one(i: 1)
  end

  def prepare_large
    puts "Inserting large test data..."
    large_collection.delete_many
    puts "Large test data"
    large_iter_count.times do |i|
      large_collection.insert_one(i: i, data: 'y' * (15000000 + i))
    end
    large_collection.indexes.create_one(i: 1)
  end

  def read_small
    batch_size = self.small_batch_size
    collection = self.small_collection

    puts "Warming up..."
    (small_iter_count/5).times do |i|
      collection.find({}, batch_size: batch_size).to_a
    end

    puts "Benchmarking small read..."
    time = Benchmark.realtime do
      small_iter_count.times do |i|
        collection.find({}, batch_size: batch_size).to_a
      end
    end

    puts "%.2f reads/second of #{small_data_size} small documents with batch size #{small_batch_size}" % (small_iter_count.to_f / time)
  end

  def read_large
    puts "Warming up..."
    (large_iter_count/5).times do |i|
      large_collection.find(i: i).to_a
    end

    puts "Benchmarking large read..."
    time = Benchmark.realtime do
      large_iter_count.times do |i|
        large_collection.find(i: i).to_a
      end
    end

    puts "%.2f reads/second of large documents" % (large_iter_count.to_f / time)
  end

  def apply_load(factor)
    puts "Applying load"
    require 'mongoid'
    require_relative '../ssl-perf/load'
    load(factor)
    # This makes runs more reproducible by avoiding GC of pre-benchmark
    # data during the benchmark itself
    GC.start
  end

  def run
    prepare_small
    prepare_large
    read_small
    read_large
    apply_load(300)
    read_small
    read_large
  end
end

if pid = fork
  Process.wait pid
else
  puts 'Non-SSL'
  no_ssl = Bench.new('mongodb://localhost:27100/?connect=direct')
  no_ssl.run
  exit
end

if pid = fork
  Process.wait pid
else
  puts 'SSL'
  ssl = Bench.new('mongodb://localhost:27400/?ssl=true&connect=direct')
  ssl.run
  exit
end
