require_relative './tester'

class ClientTester < Tester
  def run_delegated
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
  end

  def perform_operation
    collection.find(a: 1).to_a
  end
end

config_path = ARGV.shift or raise 'need config file'
ClientTester.new(config_path).run
