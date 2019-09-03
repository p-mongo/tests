require 'faraday'
begin
  require 'byebug'
rescue LoadError
end

class Tester
  def initialize(uri)
    @uri = uri
    @threads = []
    @read_ops = 0
    @exception_count = 0
    @lock = Mutex.new
  end

  attr_reader :uri
  attr_reader :exception_count

  def logger
    @logger ||= Logger.new(File.open('client.log', 'w'))
  end

  def reader_thread_count
    20
  end

  def run
    reader_thread_count.times do |i|
      client = Faraday.new(:url => @uri) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        #faraday.response :logger                  # log requests to $stdout
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end

      @threads << run_thread_loop("reader-#{i}") do
        resp = client.get('/')
        failed = false
        if resp.status != 200
          puts "Bad status in reader-#{i}: #{resp.status}"
          failed = true
        end
        body = resp.body
        unless body['ok']
          puts "Operation failed: #{body['error']}"
          failed = true
        end
        if failed
          @lock.synchronize do
            @exception_count += 1
          end
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
        #puts e.backtrace.join("\n")
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
          #puts e.backtrace.join("\n")
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
      prev_read_ops = read_ops
    end
  end
end

uri = ARGV.shift || 'http://localhost:9292'
Tester.new(uri).run
