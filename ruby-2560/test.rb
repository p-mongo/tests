require 'mongo'

client = Mongo::Client.new(['localhost:14400'])
#client = Mongo::Client.new(['localhost:14900'], server_api:{version:'1'})

client['foo'].drop
client['foo'].indexes.create_one({k: 1}, unique: true)

rep = '(╯°□°)╯︵ ┻━┻(╯°□°)╯︵ ┻━┻'

client['foo'].insert_one(k: rep*10)
client['foo'].insert_one(k: rep*10)
