require 'mongoid'
require 'faraday'
require_relative './tester'

class AppTester < Tester
=begin
  def prepare
    super

    @app_process = ChildProcess.new('sh', '-c', <<-EOT)
      env CONFIG_PATH=#{config_file_path} \
      puma config.puma.ru \
        -w #{options[:puma_workers]} -t #{options[:puma_threads]} \
      > #{server_log_path} 2>&1
EOT
    @app_process.start
    sleep 1
    unless @app_process.alive?
      raise "App process died with exit code #{@app_process.wait}, see logs in #{server_log_path}"
    end
  end
=end

  def run_delegated
    reader_thread_count.times do |i|
      client = Faraday.new(:url => server_base_url) do |faraday|
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
  end

  def server_base_url
    "http://localhost:#{options[:puma_port]}"
  end

  def perform_operation
    collection.find(a: 1).to_a
  end
end

config_path = ARGV.shift or raise 'need config file'
AppTester.new(config_path).run
