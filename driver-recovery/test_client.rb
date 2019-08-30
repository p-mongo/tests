begin
  require 'byebug'
rescue LoadError
end
require 'mongo'

class Tester
  def initialize(uri)
    @uri = uri
    @threads = []
    @read_ops = 0
    @exception_count = 0
    @lock = Mutex.new

    logger
    client
    collection
  end

  attr_reader :uri
  attr_reader :exception_count

  def logger
    @logger ||= Logger.new(File.open('client.log', 'w'))
  end

  def client
    @client ||= Mongo::Client.new(uri, logger: logger,
      max_pool_size: 10,
      socket_timeout: 5,
      connect_timeout: 5,
      server_selection_timeout: 5,
    )
  end

  def collection
    @collection ||= client['test-collection']
  end

  def reader_thread_count
    20
  end

  def run
    reader_thread_count.times do |i|
      @threads << run_thread_loop("reader-#{i}") do
        begin
          Timeout.timeout(20) do
            collection.find(a: 1).to_a
          end
        rescue Timeout::Error => e
          raise "Find took more than 20 seconds: #{e.class}: #{e}"
        end
        sleep 0.01
        @lock.synchronize do
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
        @lock.synchronize do
          @exception_count += 1
        end
      end
    end
  end

  def run_thread_loop(thread_label)
    Thread.new do
      until @stop
        begin
          yield
        rescue => e
          puts "Unhandled exception in thread #{thread_label}: #{e.class}: #{e}"
          puts e.backtrace.join("\n")
          @lock.synchronize do
            @exception_count += 1
          end
        end
      end
    end
  end

  def run_monitor
    prev_read_ops = @lock.synchronize { @read_ops }
    until @stop
      sleep 1
      read_ops = @lock.synchronize do
        @read_ops
      end
      alive_threads_count = @threads.select do |thread|
        thread.alive?
      end.length
      exception_count = @lock.synchronize do
        self.exception_count
      end
      puts "#{Time.now}: #{read_ops - prev_read_ops} read ops, " +
        "#{alive_threads_count} alive threads, #{exception_count} exceptions"
      puts client.cluster.summary
      prev_read_ops = read_ops
    end
  end
end

uri = ARGV.shift || 'mongodb://localhost:13480,localhost:13481,localhost:13482,localhost:13483,localhost:13484,localhost:13485,localhost:13486,localhost:13487,localhost:13488,localhost:13489'
Tester.new(uri).run
