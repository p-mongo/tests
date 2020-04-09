require 'mongo'
require 'mongo_manager'
autoload :Byebug, 'byebug'

Mongo::Logger.logger = Logger.new(STDOUT, level: :warn)

class Bouncer
  def work
    1_000_000.times do
      sleep(rand*10 + 5)
      port = (rand*3).floor + 27020
      puts "Bouncing #{port}"
      pid = get_port_pid(port)

      begin
        Process.kill('TERM', pid)
      rescue SystemCallError
        puts "No go with pid #{pid} for port #{port}"
        next
      end

      deadline = Time.now + 20
      loop do
        begin
          Process.kill(0, pid)
        rescue SystemCallError
          # Process is dead
          break
        else
          if Time.now >= deadline
            puts "Process #{pid} did not die after 20 seconds"
            next
          end
          sleep 1
        end
      end

      puts "Restarting for #{port}"
      cfg = YAML.load(File.read('/db/mongo-manager.yml'))
      key = cfg[:settings].keys.detect { |key| key.end_with?(port.to_s) }
      opts = cfg[:settings][key][:start_options]
      cmd = [
        opts[:bin_path],
        '--logpath', opts[:log_path],
        '--pidfilepath', opts[:pid_file_path],
        '--fork',
      ] + opts[:args]

      #Byebug.byebug
      puts Process.spawn(*cmd)

      #puts `mongo-manager --dir /db start`
      #MongoManager::Executor.new(dir: '/db').start
    end
  end

  private

  def client
    @client ||= Mongo::Client.new(['localhost'])
  end

  def get_port_pid(port)
    path = Dir["/db/shard1-rs*-#{port}/mongod.pid"].first
    unless path
      puts "No path for #{port}, skipping"
      return
    end

    File.read(path).to_i
  end
end

puts 'Bouncing'
Bouncer.new.work
