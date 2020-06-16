require 'mongo'

Mongo::Logger.logger.level = Logger::INFO

client = Mongo::Client.new(['localhost:14420'])

session = client.start_session
p session, session.session_id

client['coll'].insert_one(test: 1)

thread = Thread.new do
  p client['coll'].find({'$where' => 'sleep(2000) || true'}, session: session).first
end

sleep 1
p client.database.command(killSessions: [session.session_id])

thread.join
