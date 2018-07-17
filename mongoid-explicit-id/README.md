<pre>
speed% be rails c
PLoading development environment (Rails 5.1.6)
irb(main):001:0> Proxy.first
Overwriting existing field _id in class Proxy.
MONGODB | EVENT: #<Mongo::Monitoring::Event::TopologyOpening topology=Unknown>
MONGODB | Topology type 'unknown' initializing.
MONGODB | EVENT: #<Mongo::Monitoring::Event::ServerOpening address=localhost:27027 topology=Unknown>
MONGODB | Server localhost:27027 initializing.
MONGODB | EVENT: #<Mongo::Monitoring::Event::TopologyChanged prev=Unknown new=Single>
MONGODB | Topology type 'unknown' changed to type 'single'.
MONGODB | EVENT: #<Mongo::Monitoring::Event::ServerDescriptionChanged>
MONGODB | Server description for localhost:27027 changed from 'unknown' to 'standalone'.
MONGODB | EVENT: #<Mongo::Monitoring::Event::TopologyChanged prev=Single new=Single>
MONGODB | There was a change in the members of the 'single' topology.
MONGODB | localhost:27027 | mongoid.find | STARTED | {"find"=>"proxies", "filter"=>{}, "sort"=>{"_id"=>1}, "limit"=>1, "singleBatch"=>true, "lsid"=>{"id"=><BSON::Binary:0x46960348047740 type=uuid data=0xbbe2aa5224124d7f...>}}
MONGODB | localhost:27027 | mongoid.find | SUCCEEDED | 0.001s
=> nil
irb(main):002:0> Proxy.new(_id: 'hello').save!
MONGODB | localhost:27027 | mongoid.insert | STARTED | {"insert"=>"proxies", "ordered"=>true, "lsid"=>{"id"=><BSON::Binary:0x46960348047740 type=uuid data=0xbbe2aa5224124d7f...>}, "documents"=>[{"_id"=>"hello"}]}
MONGODB | localhost:27027 | mongoid.insert | SUCCEEDED | 0.027s
=> true
irb(main):003:0> Proxy.first.id
MONGODB | localhost:27027 | mongoid.find | STARTED | {"find"=>"proxies", "filter"=>{}, "sort"=>{"_id"=>1}, "limit"=>1, "singleBatch"=>true, "lsid"=>{"id"=><BSON::Binary:0x46960348047740 type=uuid data=0xbbe2aa5224124d7f...>}}
MONGODB | localhost:27027 | mongoid.find | SUCCEEDED | 0.001s
=> "hello"
</pre>
