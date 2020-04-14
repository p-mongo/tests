require 'mongo'

Mongo::Logger.logger.level = Logger::WARN

client = Mongo::Client.new('mongodb://localhost/test?authmechanism=mongodb-aws')
client['foo'].insert_one(test: 1)

