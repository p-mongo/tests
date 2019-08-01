require 'byebug'
require 'mongo'

class Tester
  def initialize(uri)
    @uri = uri
    @threads = []
    @read_ops = 0
    @exception_count = 0
  end

  attr_reader :uri
  attr_reader :exception_count

  def logger
    @logger ||= Logger.new(File.open('client.log', 'w'))
  end

  def client
    @client ||= Mongo::Client.new(uri, logger: logger)
  end

  def collection
    @collection ||= client['test-collection']
  end

  def reader_thread_count
    20
  end

  def run
    reader_thread_count.times do |i|
      @threads << run_thread("reader #{i}") do
        until @stop
          collection.find(a: 1).to_a
          sleep 0.01
          @read_ops += 1
        end
      end
    end

    @threads << run_thread('monitor') do
      run_monitor
    end

    Signal.trap('INT') do
      puts 'Stopping'
      @stop = true
    end

    until @stop
      sleep 1
    end

    @threads.map(&:join)
  end

  def run_thread(thread_label)
    Thread.new do
      begin
        yield
      rescue => e
        puts "Unhandled exception in thread #{thread_label}: #{e.class}: #{e}"
        puts e.backtrace.join("\n")
        @exception_count += 1
      end
    end
  end

  def run_monitor
    prev_read_ops = @read_ops
    until @stop
      sleep 1
      read_ops = @read_ops
      alive_threads_count = @threads.select do |thread|
        thread.alive?
      end.length
      puts "#{Time.now}: #{read_ops - prev_read_ops} read ops, " +
        "#{alive_threads_count} alive threads, #{exception_count} exceptions"
      prev_read_ops = read_ops
    end
  end
end

uri = 'mongodb://localhost:14440,localhost:14441'
Tester.new(uri).run
