require 'mongo'

#Mongo::Logger.logger.level = Logger::WARN

client = Mongo::Client.new(['localhost'])
client['coll1'].delete_many
client['coll1'].insert_one(marker: 1)

puts '---- primary read -----'

p client['coll1'].find('$where' => 'true').first

puts '---- secondary read -----'

p client['coll1'].find('$where' => 'true').
  read(mode: :secondary).first

client.close
