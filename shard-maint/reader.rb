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
        thread_client = Mongo::Client.new(['localhost'])
        1_000_000.times do
          p thread_client['coll1'].find('$where' => 'sleep(20000) || true').first
        end
      end
    end
    threads.map(&:join)
  end

  private

  def client
    @client ||= Mongo::Client.new(['localhost'])
  end
end

puts 'Reading'
Reader.new.work
puts 'Done reading'
