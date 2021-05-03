require 'benchmark'
require 'mongo'
require 'standard_deviation'

#Mongo::Logger.logger.level = 0

ITERS = 1000

client = Mongo::Client.new(['localhost:14420'], server_selection_timeout: 1)
client['foo'].delete_many

def do_test(client, *args)
  client['foo'].find(*args).first

  times = []
  ITERS.times do
    t = Benchmark.realtime do
      client['foo'].find(*args).first
    end
    times << t
  end

  times.sort!
  mean = times.sum / times.length
  median = times[times.length/2]
  p95 = times[times.length*0.95]
  p99 = times[times.length*0.99]
  dev = times.standard_deviation

  puts "Mean: #{mean}"
  puts "Median: #{median}"
  puts "95%: #{p95}"
  puts "99%: #{p99}"
  puts "Stddev: #{dev}"
end

puts
puts "Primary read"
do_test(client)

puts
puts "Primary read with conditions"
do_test(client, {foo: 1, bar: {test: 1}})

puts
puts "Primary read with explicit preference"
do_test(client.with(read: {mode: :primary}))

puts
puts "Primary read with explicit preference with conditions"
do_test(client.with(read: {mode: :primary}), {foo: 1, bar: {test: 1}})

puts
puts "Secondary read"
do_test(client.with(read: {mode: :secondary}))

puts
puts "Secondary read with conditions"
do_test(client.with(read: {mode: :secondary}), {foo: 1, bar: {test: 1}})
