require 'ruby-prof'
require 'benchmark'
require 'mongo'

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
result = nil
t = Benchmark.realtime do
  RubyProf.start
  $s=1
    collection.find(a: 1).first
  result = RubyProf.stop
end

puts "#{'%.2f' % (iter_count / t)} reads/second"

printer = RubyProf::GraphHtmlPrinter.new(result)
printer.print(File.open('prof.html', 'w'), :min_percent => 2)
exit


$load_count = 100

$load_count.times do |i|
  eval "module TestM#{i}; def f#{i}; true; end; end"
end

module TestM
  $load_count.times do |i|
    eval "include TestM#{i}"
  end
end

$load_count.times do |i|
  eval "class C#{i}; include TestM; end"
end

puts "Benchmarking..."
t = Benchmark.realtime do
  iter_count.times do
    collection.find(a: 1).first
  end
end

puts "#{'%.2f' % (iter_count / t)} reads/second"
