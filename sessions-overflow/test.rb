require 'mongo'

client = Mongo::Client.new(['localhost:14420'])

loop do
  s = client.start_session
  client['foo'].insert_one({foo: 1}, session: s)
end
