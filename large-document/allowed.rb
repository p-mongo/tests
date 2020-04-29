require 'mongo'

Mongo::Logger.logger.level = Logger::WARN

client = Mongo::Client.new('mongodb://127.0.0.1:14420/test')

doc = {_id: 'small', data: 'a' * 16_777_185 }
puts doc.to_bson.to_s.bytesize, 2**24
client['documents'].delete_many
client['documents'].insert_one(doc) # raises a Mongo::Error::OperationFailure in 2.12.1, Mongo::Error::MaxBSONSize in 2.11.4

