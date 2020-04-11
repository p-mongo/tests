require 'mongo'

Mongo::Logger.logger.level = Logger::WARN

client = Mongo::Client.new(['localhost:14420'])
coll = client['coll']

10_000.times do |i|
  doc = {
    i: i,
    a: Base64.encode64(SecureRandom.random_bytes(100)) * ((rand * 100).to_i + 100),
  }
  coll.insert_one(doc)
end
