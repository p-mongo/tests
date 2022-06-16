require 'mongo'

Mongo::Logger.logger.level = 0

client = Mongo::Client.new(['localhost'], compressors: %w(zlib))

sleep 50
