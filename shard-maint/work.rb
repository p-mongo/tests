require 'mongo'

Mongo::Logger.logger = Logger.new(STDOUT, level: :warn)

class Worker
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

puts 'Working'
Worker.new.work
