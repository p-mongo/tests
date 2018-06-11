require 'benchmark'
require 'mongoid'

Mongo::Logger.level = Logger::INFO

iter_count = (ENV['ITER_COUNT'] || 300).to_i

puts "Connecting..."

Mongoid.configure do |config|
  config.connect_to(ENV['MONGODB_URI'] || 'mongodb://127.0.0.1:27017/test' )
end

class TestDoc
  include Mongoid::Document
  store_in collection: 'test', database: 'test'

  field :i, type: Integer
  field :data, type: String
end

TestDoc.delete_all

puts "Warming up..."
(iter_count/5).times do |i|
  TestDoc.new(i: i, data: 'x' * (1000000 + i)).save!
end

puts "Benchmarking write..."
time = Benchmark.realtime do
  iter_count.times do |i|
    TestDoc.new(i: i, data: 'x' * (15000000 + i)).save!
  end
end

puts "%.2f inserts/second" % (iter_count.to_f / time)

puts "Warming up..."
(iter_count/5).times do |i|
  TestDoc.where(i: i).first
end

puts "Benchmarking read..."
time = Benchmark.realtime do
  iter_count.times do |i|
    TestDoc.where(i: i).first
  end
end

puts "%.2f reads/second" % (iter_count.to_f / time)
