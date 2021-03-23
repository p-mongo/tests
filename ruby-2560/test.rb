require 'mongo'

client = Mongo::Client.new(['localhost:14700'])

client['foo'].indexes.create_one({k: 1}, unique: true)

rep = '(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻'

client['foo'].insert_one(k: rep*10)
client['foo'].insert_one(k: rep*10)
