require 'mongo'

Mongo::Logger.logger.level = 1

client = Mongo::Client.new(['localhost:14240', 'localhost:14241'])
db1 = client[:db1]

loop do
  db1.drop
  db1.insert_one(a: 1)
  print('.')
end
