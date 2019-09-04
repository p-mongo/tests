require_relative './tester'

class AppTester < Tester
  def run_delegated
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
  end

  def perform_operation
    collection.find(a: 1).to_a
  end
end

config_path = ARGV.shift or raise 'need config file'
config = YAML.load(File.read(config_path)).deep_symbolize_keys
AppTester.new(config).run
