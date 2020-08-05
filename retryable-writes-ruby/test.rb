require 'mongo'

uri = "mongodb://localhost:14070,localhost:14071/?retrywrites=false"

client = Mongo::Client.new(uri)

client['foo'].insert_one(a: 1)

client.start_session do |s|
  s.with_transaction do
    client['foo'].insert_one({a: 2}, session: s)
  end
end
