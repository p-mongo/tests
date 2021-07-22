require 'mongo'

Mongo::Logger.logger.level = 0

client = Mongo::Client.new('mongodb://localhost:15040/x')
puts client.summary

shard = Mongo::Client.new('mongodb://localhost:15043')
puts shard.summary

shard.command(
  configureFailPoint: 'failCommand',
  mode: {times: 100},
  data: {failCommands: ['insert'], errorCode: 11600},
)

client['foo'].insert_one(test: 1)
#client['foo'].find(a: 1).first
