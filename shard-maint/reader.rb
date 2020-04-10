require 'mongo'

#Mongo::Logger.logger = Logger.new(STDOUT, level: :warn)
Mongo::Logger.logger.level = Logger::WARN

class Reader
  def work
    client['coll1'].delete_many
    client['coll1'].insert_one(marker: 1)
    client.close

    threads = []
    20.times do
      threads << Thread.new do
        thread_client = Mongo::Client.new('mongodb://localhost/test')
        1_000_000.times do
          begin
            p thread_client['coll1'].find('$where' => 'sleep(20000) || true').
              read(mode: :secondary).first
          rescue => e
            msg = "********* Error in reader: #{e.class}: #{e}"
            inspect_client = Mongo::Client.new(
              %w(localhost:27020 localhost:27021 localhost:27022)
            )
            puts "#{msg}\nShard summary: #{inspect_client.cluster.summary}\n`````````"
            inspect_client.close
          end
        end
      end
    end
    threads.map(&:join)
  end

  private

  def client
    @client ||= Mongo::Client.new('mongodb://localhost/test')
  end
end

puts 'Reading'
Reader.new.work
puts 'Done reading'
