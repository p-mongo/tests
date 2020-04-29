require 'mongo'

client = Mongo::Client.new('mongodb://127.0.0.1:14420/test')

client['documents'].insert_one({name: 'small', data: 'a' * 16_777_216 }) # raises a Mongo::Error::OperationFailure in 2.12.1, Mongo::Error::MaxBSONSize in 2.11.4

