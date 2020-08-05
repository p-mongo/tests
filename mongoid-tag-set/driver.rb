require 'mongo'

if false

uri = "mongodb://cluster2-shard-00-00.zi3an.mongodb.net:27017,cluster2-shard-00-01.zi3an.mongodb.net:27017,cluster2-shard-00-02.zi3an.mongodb.net:27017,cluster2-shard-00-03.zi3an.mongodb.net:27017/x?replicaSet=atlas-orww16-shard-0&authSource=admin&tls=true"

client = Mongo::Client.new(uri, server_selection_timeout: 1, read: {
  mode: :secondary, tag_sets: [nodeType: 'ANALYTICS']})

else

uri = "mongodb://cluster2-shard-00-00.zi3an.mongodb.net:27017,cluster2-shard-00-01.zi3an.mongodb.net:27017,cluster2-shard-00-02.zi3an.mongodb.net:27017,cluster2-shard-00-03.zi3an.mongodb.net:27017/x?replicaSet=atlas-orww16-shard-0&authSource=admin&tls=true&readpreference=secondary&readpreferencetags=nodeType:ANALYTICS"

client = Mongo::Client.new(uri, server_selection_timeout: 1)

end

p client.options

p client.cluster.summary

p(client.cluster.servers.map do |server|
  server.description.tags
end)

p client['foo'].find.to_a
