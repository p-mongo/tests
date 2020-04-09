require 'mongo'

#Mongo::Logger.logger = Logger.new(STDOUT, level: :warn)
Mongo::Logger.logger.level = Logger::WARN

class Writer
  def work
    1_000_000.times do
      client['coll'].insert_one(test: 'x'*10000)
    end
  end

  private

  def client
    @client ||= Mongo::Client.new(['localhost'])
  end
end

puts 'Writing'
Writer.new.work
