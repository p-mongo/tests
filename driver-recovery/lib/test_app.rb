require 'mongoid'
autoload :Faraday, 'faraday'
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

  def net_client
    @net_client ||= Faraday.new(:url => server_base_url) do |faraday|
      #faraday.request  :url_encoded             # form-encode POST params
      #faraday.response :logger                  # log requests to $stdout
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def perform_operation
    resp = net_client.get('/')
    failed = false
    if resp.status != 200
      puts "Bad status in reader-#{i}: #{resp.status}"
      failed = true
    end
    body = JSON.parse(resp.body)
    unless body['ok']
      puts "Operation failed: #{body['error']}"
      failed = true
    end
    if failed
      raise OperationFailed
    end
  end

  def server_base_url
    "http://localhost:#{options[:puma_port]}"
  end
end
