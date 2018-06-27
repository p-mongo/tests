require 'benchmark'
require 'mongo'
require_relative 'load'

Mongo::Logger.level = Logger::INFO

iter_count = (ENV['ITER_COUNT'] || 10).to_i

puts "Connecting..."
client = Mongo::Client.new(
  ENV['MONGODB_URI'] || [ '127.0.0.1:27400' ],
  database: 'test',
  ssl: true,
  ssl_verify: false,
  #ssl_ca_cert: '/tmp/root.crt',
  #ssl_key: '/tmp/localhost:27017.pem',
)

collection = client[:test]

collection.delete_many
collection.insert_one(a:1, data: 'x'*15000000)
collection.find(a:1)

puts "Benchmarking..."
t = Benchmark.realtime do
  iter_count.times do
    collection.find(a: 1).first
  end
end

puts "#{'%.2f' % (iter_count / t)} reads/second"

load(100)

puts "Benchmarking..."
t = Benchmark.realtime do
  iter_count.times do
    collection.find(a: 1).first
  end
end

puts "#{'%.2f' % (iter_count / t)} reads/second"
