require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'

  gem 'bson'
  gem 'memory_profiler'
end

require 'benchmark'

ITERATIONS = 1_000_000

def time_benchmark(&block)
  Benchmark.measure do
    ITERATIONS.times { block.call }
  end.real
end

def memory_benchmark(&block)
  MemoryProfiler.report do
    ITERATIONS.times { block.call }
  end.total_allocated_memsize.to_f / 1024**2
end

puts 'Current implementation'

date = Date.today
buffer = BSON::ByteBuffer.new
code = proc { date.to_bson(buffer) }

puts "Time: #{time_benchmark(&code)}"
puts "Memory: #{memory_benchmark(&code)} MB"

module BSON
  module DateImprovement
    REFERENCE = ::Date.new(1970, 1, 1).jd
    MILISECONDS_IN_DAY = 60 * 60 * 24 * 1_000

    def to_bson(buffer = ByteBuffer.new, validating_keys = Config.validating_keys?)
      buffer.put_int64((jd - REFERENCE) * MILISECONDS_IN_DAY)
    end
  end
end

Date.include(BSON::DateImprovement)
date = Date.today

puts 'With improvement'

puts "Time: #{time_benchmark(&code)}"
puts "Memory: #{memory_benchmark(&code)} MB"
