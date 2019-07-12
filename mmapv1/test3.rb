require 'mongo'

client = Mongo::Client.new('mongodb://localhost:27017/foo?retryWrites=false&retryReads=false')
p client.options

client = Mongo::Client.new('mongodb://localhost:27017/foo', retry_reads: false, retry_writes: false)
p client.options

collection = client[:people]

doc = { name: 'Adam', hobbies: [ 'running', 'games' ] }
result = collection.insert_one(doc)
result.n
