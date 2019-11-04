# SDAM monitoring sample w/Mongoid

This application illustrates how to obtain debug level driver logging
in a Mongoid application, with respect to SDAM events.

In `config/mongoid.yml`, set the logging level to debug:

<pre>
development:
  clients:
    default:
      database: mongoid
      hosts:
        - localhost:14420
      options:
        log_level: debug
</pre>

Then, running `rails c` produces the following output in the console:

<pre>
speed% rails c
Loading development environment (Rails 5.2.3)
irb(main):003:0> Band.count
MONGODB | Unsupported client option 'log_level'. It will be ignored.
MONGODB | EVENT: #<TopologyOpening topology=Unknown[]>
MONGODB | Topology type 'unknown' initializing.
MONGODB | EVENT: #<TopologyChanged prev=Unknown[] new=Unknown[localhost:14420]>
MONGODB | Topology type 'Unknown' changed to type 'Unknown'.
MONGODB | EVENT: #<ServerOpening address=localhost:14420 topology=Unknown[localhost:14420]>
MONGODB | Server localhost:14420 initializing.
MONGODB | Waiting for up to 30.00 seconds for servers to be scanned: #<Cluster topology=Unknown[localhost:14420] servers=[#<Server address=localhost:14420 UNKNOWN>]>
MONGODB | EVENT: #<ServerDescriptionChanged address=localhost:14420 topology=ReplicaSetNoPrimary[localhost:14420,name=ruby-driver-rs] prev=#<Mongo::Server:Description:0x47117601703720 config={} average_round_trip_time=> new=#<Mongo::Server:Description:0x47117601823680 config={"hosts"=>["localhost:14420", "localhost:14421", "localhost:14422"], "setName"=>"ruby-driver-rs", "setVersion"=>19, "ismaster"=>false, "secondary"=>true, "primary"=>"localhost:14421", "me"=>"localhost:14420", "lastWrite"=>{"opTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7d5c208 @seconds=1572905899, @increment=1>, "t"=>8}, "lastWriteDate"=>2019-11-04 22:18:19 UTC, "majorityOpTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7d6bfa0 @seconds=1572905899, @increment=1>, "t"=>8}, "majorityWriteDate"=>2019-11-04 22:18:19 UTC}, "maxBsonObjectSize"=>16777216, "maxMessageSizeBytes"=>48000000, "maxWriteBatchSize"=>100000, "localTime"=>2019-11-04 22:18:27 UTC, "logicalSessionTimeoutMinutes"=>30, "connectionId"=>6730, "minWireVersion"=>0, "maxWireVersion"=>8, "readOnly"=>false, "ok"=>1.0, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x000055b4d7d6ba78 @seconds=1572905899, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x47117601823880 type=generic data=0x0000000000000000...>, "keyId"=>0}}, "operationTime"=>#<BSON::Timestamp:0x000055b4d7d6b870 @seconds=1572905899, @increment=1>} average_round_trip_time=0.002086726>>
MONGODB | Server description for localhost:14420 changed from 'unknown' to 'secondary'.
MONGODB | EVENT: #<TopologyChanged prev=Unknown[localhost:14420] new=ReplicaSetNoPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs]>
MONGODB | Topology type 'Unknown' changed to type 'ReplicaSetNoPrimary'.
MONGODB | EVENT: #<ServerOpening address=localhost:14421 topology=ReplicaSetNoPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs]>
MONGODB | Server localhost:14421 initializing.
MONGODB | EVENT: #<ServerOpening address=localhost:14422 topology=ReplicaSetNoPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs]>
MONGODB | Server localhost:14422 initializing.
MONGODB | Waiting for up to 30.00 seconds for servers to be scanned: #<Cluster topology=ReplicaSetNoPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs] servers=[#<Server address=localhost:14420 SECONDARY replica_set=ruby-driver-rs pool=#<ConnectionPool size=0 (0-5) used=0 avail=0 pending=0>>,#<Server address=localhost:14421 UNKNOWN>,#<Server address=localhost:14422 UNKNOWN>]>
MONGODB | EVENT: #<ServerDescriptionChanged address=localhost:14421 topology=ReplicaSetWithPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs,v=19,e=7fffffff0000000000000008] prev=#<Mongo::Server:Description:0x47117601849240 config={} average_round_trip_time=> new=#<Mongo::Server:Description:0x47117601963900 config={"hosts"=>["localhost:14420", "localhost:14421", "localhost:14422"], "setName"=>"ruby-driver-rs", "setVersion"=>19, "ismaster"=>true, "secondary"=>false, "primary"=>"localhost:14421", "me"=>"localhost:14421", "electionId"=>BSON::ObjectId('7fffffff0000000000000008'), "lastWrite"=>{"opTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7d99130 @seconds=1572905899, @increment=1>, "t"=>8}, "lastWriteDate"=>2019-11-04 22:18:19 UTC, "majorityOpTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7d98ed8 @seconds=1572905899, @increment=1>, "t"=>8}, "majorityWriteDate"=>2019-11-04 22:18:19 UTC}, "maxBsonObjectSize"=>16777216, "maxMessageSizeBytes"=>48000000, "maxWriteBatchSize"=>100000, "localTime"=>2019-11-04 22:18:27 UTC, "logicalSessionTimeoutMinutes"=>30, "connectionId"=>5766, "minWireVersion"=>0, "maxWireVersion"=>8, "readOnly"=>false, "ok"=>1.0, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x000055b4d7d98258 @seconds=1572905899, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x47117601915000 type=generic data=0x0000000000000000...>, "keyId"=>0}}, "operationTime"=>#<BSON::Timestamp:0x000055b4d7d98078 @seconds=1572905899, @increment=1>} average_round_trip_time=0.002156866>>
MONGODB | Server description for localhost:14421 changed from 'unknown' to 'primary'.
MONGODB | EVENT: #<TopologyChanged prev=ReplicaSetNoPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs] new=ReplicaSetWithPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs,v=19,e=7fffffff0000000000000008]>
MONGODB | Topology type 'ReplicaSetNoPrimary' changed to type 'ReplicaSetWithPrimary'.
MONGODB | EVENT: #<ServerDescriptionChanged address=localhost:14422 topology=ReplicaSetWithPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs,v=19,e=7fffffff0000000000000008] prev=#<Mongo::Server:Description:0x47117601847120 config={} average_round_trip_time=> new=#<Mongo::Server:Description:0x47117601987940 config={"hosts"=>["localhost:14420", "localhost:14421", "localhost:14422"], "setName"=>"ruby-driver-rs", "setVersion"=>19, "ismaster"=>false, "secondary"=>true, "primary"=>"localhost:14421", "me"=>"localhost:14422", "lastWrite"=>{"opTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7db0538 @seconds=1572905899, @increment=1>, "t"=>8}, "lastWriteDate"=>2019-11-04 22:18:19 UTC, "majorityOpTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7db0358 @seconds=1572905899, @increment=1>, "t"=>8}, "majorityWriteDate"=>2019-11-04 22:18:19 UTC}, "maxBsonObjectSize"=>16777216, "maxMessageSizeBytes"=>48000000, "maxWriteBatchSize"=>100000, "localTime"=>2019-11-04 22:18:27 UTC, "logicalSessionTimeoutMinutes"=>30, "connectionId"=>5364, "minWireVersion"=>0, "maxWireVersion"=>8, "readOnly"=>false, "ok"=>1.0, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x000055b4d7dbbe38 @seconds=1572905899, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x47117601988200 type=generic data=0x0000000000000000...>, "keyId"=>0}}, "operationTime"=>#<BSON::Timestamp:0x000055b4d7dbbc58 @seconds=1572905899, @increment=1>} average_round_trip_time=0.002867046>>
MONGODB | Server description for localhost:14422 changed from 'unknown' to 'secondary'.
MONGODB | EVENT: #<TopologyChanged prev=ReplicaSetWithPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs,v=19,e=7fffffff0000000000000008] new=ReplicaSetWithPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs,v=19,e=7fffffff0000000000000008]>
MONGODB | Topology type 'ReplicaSetWithPrimary' changed to type 'ReplicaSetWithPrimary'.
MONGODB | EVENT: #<ServerDescriptionChanged address=localhost:14421 topology=ReplicaSetWithPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs,v=19,e=7fffffff0000000000000008] prev=#<Mongo::Server:Description:0x47117601963900 config={"hosts"=>["localhost:14420", "localhost:14421", "localhost:14422"], "setName"=>"ruby-driver-rs", "setVersion"=>19, "ismaster"=>true, "secondary"=>false, "primary"=>"localhost:14421", "me"=>"localhost:14421", "electionId"=>BSON::ObjectId('7fffffff0000000000000008'), "lastWrite"=>{"opTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7d99130 @seconds=1572905899, @increment=1>, "t"=>8}, "lastWriteDate"=>2019-11-04 22:18:19 UTC, "majorityOpTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7d98ed8 @seconds=1572905899, @increment=1>, "t"=>8}, "majorityWriteDate"=>2019-11-04 22:18:19 UTC}, "maxBsonObjectSize"=>16777216, "maxMessageSizeBytes"=>48000000, "maxWriteBatchSize"=>100000, "localTime"=>2019-11-04 22:18:27 UTC, "logicalSessionTimeoutMinutes"=>30, "connectionId"=>5766, "minWireVersion"=>0, "maxWireVersion"=>8, "readOnly"=>false, "ok"=>1.0, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x000055b4d7d98258 @seconds=1572905899, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x47117601915000 type=generic data=0x0000000000000000...>, "keyId"=>0}}, "operationTime"=>#<BSON::Timestamp:0x000055b4d7d98078 @seconds=1572905899, @increment=1>} average_round_trip_time=0.002156866> new=#<Mongo::Server:Description:0x47117602157100 config={"hosts"=>["localhost:14420", "localhost:14421", "localhost:14422"], "setName"=>"ruby-driver-rs", "setVersion"=>19, "ismaster"=>true, "secondary"=>false, "primary"=>"localhost:14421", "me"=>"localhost:14421", "electionId"=>BSON::ObjectId('7fffffff0000000000000008'), "lastWrite"=>{"opTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7e0ed40 @seconds=1572905899, @increment=1>, "t"=>8}, "lastWriteDate"=>2019-11-04 22:18:19 UTC, "majorityOpTime"=>{"ts"=>#<BSON::Timestamp:0x000055b4d7e0ebb0 @seconds=1572905899, @increment=1>, "t"=>8}, "majorityWriteDate"=>2019-11-04 22:18:19 UTC}, "maxBsonObjectSize"=>16777216, "maxMessageSizeBytes"=>48000000, "maxWriteBatchSize"=>100000, "localTime"=>2019-11-04 22:18:27 UTC, "logicalSessionTimeoutMinutes"=>30, "connectionId"=>5768, "minWireVersion"=>0, "maxWireVersion"=>8, "readOnly"=>false, "ok"=>1.0, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x000055b4d7e0e7c8 @seconds=1572905899, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x47117602157360 type=generic data=0x0000000000000000...>, "keyId"=>0}}, "operationTime"=>#<BSON::Timestamp:0x000055b4d7e0e5c0 @seconds=1572905899, @increment=1>} average_round_trip_time=0.0018307298>>
MONGODB | Server description for localhost:14421 changed from 'primary' to 'primary'.
MONGODB | EVENT: #<TopologyChanged prev=ReplicaSetWithPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs,v=19,e=7fffffff0000000000000008] new=ReplicaSetWithPrimary[localhost:14420,localhost:14421,localhost:14422,name=ruby-driver-rs,v=19,e=7fffffff0000000000000008]>
MONGODB | Topology type 'ReplicaSetWithPrimary' changed to type 'ReplicaSetWithPrimary'.
MONGODB | [9] localhost:14421 #1 | mongoid.count | STARTED | {"count"=>"bands", "query"=>{}, "lsid"=>{"id"=><BSON::Binary:0x47117602063380 type=uuid data=0xc8d8a90aefbd46fd...>}}
MONGODB | [9] localhost:14421 | mongoid.count | SUCCEEDED | 0.000s
=> 0
</pre>
