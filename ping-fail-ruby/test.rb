require 'mongo'

Mongo::Logger.logger.level = Logger::INFO

client = Mongo::Client.new(['localhost'], database: 'f')

loop do
  p client.command(ping: 1)
  p 1
end
