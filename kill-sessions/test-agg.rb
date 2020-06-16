require 'mongo'

Mongo::Logger.logger.level = Logger::INFO

client = Mongo::Client.new(['localhost:14420'])

session = client.start_session
p session, session.session_id

client['coll'].delete_many
5.times do
  client['coll'].insert_many([test: 1]*100000)
end

thread = Thread.new do
  p client['coll'].aggregate([
  '$lookup' => {from: 'coll', localField: 'test', foreignField: 'test', as: 'test'},
  ], session: session, allow_disk_use: true).first
end

sleep 1
p client.database.command(killSessions: [session.session_id])

thread.join
