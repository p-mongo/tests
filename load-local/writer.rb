require 'mongo'

#Mongo::Logger.logger = Logger.new(STDOUT, level: :warn)
Mongo::Logger.logger.level = Logger::WARN

DOC_SIZE = 10

class Writer
  def work
    loop do
      client['coll'].insert_one(test: 'x'*DOC_SIZE)
    end
  end

  private

  def client
    @client ||= Mongo::Client.new(['localhost:14420','localhost:14421','localhost:14422'], database: 'load')
  end
end

puts 'Writing'
Writer.new.work
