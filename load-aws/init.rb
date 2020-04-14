require 'mongo'

#Mongo::Logger.logger.level = Logger::WARN

client = Mongo::Client.new(['node1.1337.cx'])
config = {
  _id: 'apples',
  members: [
    {_id: 1, host: 'node1.1337.cx'},
    {_id: 2, host: 'node2.1337.cx'},
    {_id: 3, host: 'node3.1337.cx'},
  ],
}
client.database.command(replSetInitiate: config)
