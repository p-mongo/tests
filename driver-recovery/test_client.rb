require 'childprocess'
begin
  require 'byebug'
rescue LoadError
end
require 'mongo'
require 'active_support/core_ext/hash'

ChildProcess.posix_spawn = true

class OurTimeoutError < StandardError; end

class Tester
  def initialize(options)
    @options = options
    @threads = []
    @read_ops = 0
    @exception_count = 0
    @lock = Mutex.new

    logger
    client
    collection
  end

  attr_reader :options
  attr_reader :exception_count

  def logger
    @logger ||= Logger.new(File.open('client.log', 'w'))
  end

  def client
    @client ||= Mongo::Client.new(options[:uri], logger: logger,
      **options[:client_options] || {})
  end

  def collection
    @collection ||= client['test-collection']
  end

  def reader_thread_count
    options[:application_threads] || 20
  end

  def prepare
    if options[:preexec]
      options[:preexec].each do |cmd|
        execute(cmd)
      end
    end
  end

  def execute(cmd)
    if sh_cmd = cmd[:sh]
      puts "Run #{sh_cmd}"
      proc = ChildProcess.new('sh', '-c', sh_cmd)
      proc.start
      proc.wait
      unless proc.exit_code == 0
        raise "Failed to execute #{cmd}"
      end
    else
      raise "Don't know what to do with #{cmd}"
    end
  end

  def run
    prepare

    reader_thread_count.times do |i|
      @threads << run_thread_loop("reader-#{i}") do
        begin
          do_run_loop_iteration
        rescue OurTimeoutError => e
          raise "Find operation timed out by the application: #{e.class}: #{e}"
        end
        sleep 0.01
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

  def target_ops
    options[:target_ops] || 100
  end

  def do_run_loop_iteration
    target_time = Time.now + 1
    ops = 0
    while Time.now < target_time
      do_one_find
      ops += 1
      if ops >= target_ops
        break
      end
    end
    delta = target_time - Time.now
    if delta > 0
      sleep delta
    end
  end

  def do_one_find
    if options[:application_timeout]
      Timeout.timeout(options[:application_timeout], OurTimeoutError) do
        do_find_itself
      end
    else
      do_find_itself
    end
  end

  def do_find_itself
    collection.find(a: 1).to_a
    @lock.synchronize do
      @read_ops += 1
    end
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

config_path = ARGV.shift or raise 'need config file'
config = YAML.load(File.read(config_path)).deep_symbolize_keys
Tester.new(config).run
