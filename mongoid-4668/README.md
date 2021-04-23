7.1.7:

```
serene% ruby test.rb
7.1.7
2.14.0
D, [2021-04-23T10:41:16.835579 #27359] DEBUG -- : MONGODB | Topology type 'unknown' initializing.
D, [2021-04-23T10:41:16.835743 #27359] DEBUG -- : MONGODB | There was a change in the members of the 'Unknown' topology.
D, [2021-04-23T10:41:16.835850 #27359] DEBUG -- : MONGODB | Server localhost:14920 initializing.
D, [2021-04-23T10:41:16.835994 #27359] DEBUG -- : MONGODB | Waiting for up to 30.00 seconds for servers to be scanned: #<Cluster topology=Unknown[localhost:14920] servers=[#<Server address=localhost:14920 UNKNOWN>]>
D, [2021-04-23T10:41:16.837408 #27359] DEBUG -- : MONGODB | Server description for localhost:14920 changed from 'unknown' to 'primary'.
D, [2021-04-23T10:41:16.837767 #27359] DEBUG -- : MONGODB | Server localhost:14921 initializing.
D, [2021-04-23T10:41:16.838002 #27359] DEBUG -- : MONGODB | Server localhost:14922 initializing.
D, [2021-04-23T10:41:16.838229 #27359] DEBUG -- : MONGODB | Server localhost:14923 initializing.
D, [2021-04-23T10:41:16.838510 #27359] DEBUG -- : MONGODB | Topology type 'Unknown' changed to type 'ReplicaSetWithPrimary'.
D, [2021-04-23T10:41:16.838953 #27359] DEBUG -- : MONGODB | Waiting for up to 30.00 seconds for servers to be scanned: #<Cluster topology=ReplicaSetWithPrimary[localhost:14920,localhost:14921,localhost:14922,localhost:14923,name=ruby-driver-rs,v=1,e=7fffffff0000000000000001] servers=[#<Server address=localhost:14920 PRIMARY replica_set=ruby-driver-rs pool=#<ConnectionPool size=0 (0-5) used=0 avail=0 pending=0>>,#<Server address=localhost:14921 UNKNOWN>,#<Server address=localhost:14922 UNKNOWN>,#<Server address=localhost:14923 UNKNOWN>]>
D, [2021-04-23T10:41:16.839300 #27359] DEBUG -- : MONGODB | Server description for localhost:14921 changed from 'unknown' to 'secondary'.
D, [2021-04-23T10:41:16.840110 #27359] DEBUG -- : MONGODB | There was a change in the members of the 'ReplicaSetWithPrimary' topology.
D, [2021-04-23T10:41:16.840270 #27359] DEBUG -- : MONGODB | Server description for localhost:14922 changed from 'unknown' to 'secondary'.
D, [2021-04-23T10:41:16.840589 #27359] DEBUG -- : MONGODB | There was a change in the members of the 'ReplicaSetWithPrimary' topology.
D, [2021-04-23T10:41:16.840942 #27359] DEBUG -- : MONGODB | Waiting for up to 29.99 seconds for servers to be scanned: #<Cluster topology=ReplicaSetWithPrimary[localhost:14920,localhost:14921,localhost:14922,localhost:14923,name=ruby-driver-rs,v=1,e=7fffffff0000000000000001] servers=[#<Server address=localhost:14920 PRIMARY replica_set=ruby-driver-rs pool=#<ConnectionPool size=0 (0-5) used=0 avail=0 pending=0>>,#<Server address=localhost:14921 SECONDARY replica_set=ruby-driver-rs pool=#<ConnectionPool size=0 (0-5) used=0 avail=0 pending=0>>,#<Server address=localhost:14922 SECONDARY replica_set=ruby-driver-rs pool=#<ConnectionPool size=0 (0-5) used=0 avail=0 pending=0>>,#<Server address=localhost:14923 UNKNOWN>]>
D, [2021-04-23T10:41:16.841017 #27359] DEBUG -- : MONGODB | Server description for localhost:14923 changed from 'unknown' to 'arbiter'.
D, [2021-04-23T10:41:16.841318 #27359] DEBUG -- : MONGODB | There was a change in the members of the 'ReplicaSetWithPrimary' topology.
D, [2021-04-23T10:41:16.842954 #27359] DEBUG -- : MONGODB | localhost:14920 req:14 conn:1:1 sconn:594 | test.insert | STARTED | {"insert"=>"foos", "ordered"=>true, "documents"=>[{"_id"=>BSON::ObjectId('6082dc8c2c97a66adf7c9acb'), "x"=>"bar"}], "$db"=>"test", "txnNumber"=>#<BSON::Int64:0x000055f7252878d8 @value=1>, "lsid"=>{"id"=><BSON::Binary:0x1960 type=uuid data=0xf56bd512ad...
D, [2021-04-23T10:41:16.843561 #27359] DEBUG -- : MONGODB | localhost:14920 req:14 | test.insert | SUCCEEDED | 0.000s
D, [2021-04-23T10:41:16.844671 #27359] DEBUG -- : MONGODB | localhost:14920 req:15 conn:1:1 sconn:594 | test.find | STARTED | {"find"=>"foos", "filter"=>{"_id"=>BSON::ObjectId('6082dc8c2c97a66adf7c9acb'), "$and"=>[{"_id"=>BSON::ObjectId('6082dc8c2c97a66adf7c9acb')}]}, "$db"=>"test", "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x000055f725284840 @seconds=1619188876, @in...
D, [2021-04-23T10:41:16.845073 #27359] DEBUG -- : MONGODB | localhost:14920 req:15 | test.find | SUCCEEDED | 0.000s
"bar"
D, [2021-04-23T10:41:16.852082 #27359] DEBUG -- : MONGODB | localhost:14920 req:17 conn:1:2 sconn:595 | admin.endSessions | STARTED | {"endSessions"=>[{"id"=><BSON::Binary:0x1960 type=uuid data=0xf56bd512ad2e42d7...>}], "$db"=>"admin", "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x000055f725284840 @seconds=1619188876, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x1980 t...
D, [2021-04-23T10:41:16.852324 #27359] DEBUG -- : MONGODB | localhost:14920 req:17 | admin.endSessions | SUCCEEDED | 0.000s
```

7.2.2:

```
serene% ruby test.rb
7.2.2
2.14.0
D, [2021-04-23T10:41:02.167305 #27290] DEBUG -- : MONGODB | Topology type 'unknown' initializing.
D, [2021-04-23T10:41:02.167493 #27290] DEBUG -- : MONGODB | There was a change in the members of the 'Unknown' topology.
D, [2021-04-23T10:41:02.167588 #27290] DEBUG -- : MONGODB | Server localhost:14920 initializing.
D, [2021-04-23T10:41:02.167745 #27290] DEBUG -- : MONGODB | Waiting for up to 30.00 seconds for servers to be scanned: #<Cluster topology=Unknown[localhost:14920] servers=[#<Server address=localhost:14920 UNKNOWN>]>
D, [2021-04-23T10:41:02.169056 #27290] DEBUG -- : MONGODB | Server description for localhost:14920 changed from 'unknown' to 'primary'.
D, [2021-04-23T10:41:02.169358 #27290] DEBUG -- : MONGODB | Server localhost:14921 initializing.
D, [2021-04-23T10:41:02.169498 #27290] DEBUG -- : MONGODB | Server localhost:14922 initializing.
D, [2021-04-23T10:41:02.169722 #27290] DEBUG -- : MONGODB | Server localhost:14923 initializing.
D, [2021-04-23T10:41:02.169862 #27290] DEBUG -- : MONGODB | Topology type 'Unknown' changed to type 'ReplicaSetWithPrimary'.
D, [2021-04-23T10:41:02.170401 #27290] DEBUG -- : MONGODB | Waiting for up to 30.00 seconds for servers to be scanned: #<Cluster topology=ReplicaSetWithPrimary[localhost:14920,localhost:14921,localhost:14922,localhost:14923,name=ruby-driver-rs,v=1,e=7fffffff0000000000000001] servers=[#<Server address=localhost:14920 PRIMARY replica_set=ruby-driver-rs pool=#<ConnectionPool size=0 (0-5) used=0 avail=0 pending=0>>,#<Server address=localhost:14921 UNKNOWN>,#<Server address=localhost:14922 UNKNOWN>,#<Server address=localhost:14923 UNKNOWN>]>
D, [2021-04-23T10:41:02.171232 #27290] DEBUG -- : MONGODB | Server description for localhost:14921 changed from 'unknown' to 'secondary'.
D, [2021-04-23T10:41:02.171703 #27290] DEBUG -- : MONGODB | There was a change in the members of the 'ReplicaSetWithPrimary' topology.
D, [2021-04-23T10:41:02.171805 #27290] DEBUG -- : MONGODB | Server description for localhost:14923 changed from 'unknown' to 'arbiter'.
D, [2021-04-23T10:41:02.171903 #27290] DEBUG -- : MONGODB | There was a change in the members of the 'ReplicaSetWithPrimary' topology.
D, [2021-04-23T10:41:02.172483 #27290] DEBUG -- : MONGODB | Server description for localhost:14922 changed from 'unknown' to 'secondary'.
D, [2021-04-23T10:41:02.172694 #27290] DEBUG -- : MONGODB | There was a change in the members of the 'ReplicaSetWithPrimary' topology.
D, [2021-04-23T10:41:02.174741 #27290] DEBUG -- : MONGODB | localhost:14920 req:14 conn:1:1 sconn:590 | test.insert | STARTED | {"insert"=>"foos", "ordered"=>true, "documents"=>[{"_id"=>BSON::ObjectId('6082dc7e2c97a66a9afb71a3'), "x"=>/bar/}], "$db"=>"test", "txnNumber"=>#<BSON::Int64:0x00005568e4815720 @value=1>, "lsid"=>{"id"=><BSON::Binary:0x1960 type=uuid data=0xf2c7081370...
D, [2021-04-23T10:41:02.175401 #27290] DEBUG -- : MONGODB | localhost:14920 req:14 | test.insert | SUCCEEDED | 0.000s
D, [2021-04-23T10:41:02.176844 #27290] DEBUG -- : MONGODB | localhost:14920 req:15 conn:1:1 sconn:590 | test.find | STARTED | {"find"=>"foos", "filter"=>{"_id"=>BSON::ObjectId('6082dc7e2c97a66a9afb71a3'), "$and"=>[{"_id"=>BSON::ObjectId('6082dc7e2c97a66a9afb71a3')}]}, "$db"=>"test", "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x00005568e47fd878 @seconds=1619188862, @in...
D, [2021-04-23T10:41:02.177265 #27290] DEBUG -- : MONGODB | localhost:14920 req:15 | test.find | SUCCEEDED | 0.000s
#<BSON::Regexp::Raw:0x00005568e47d1430 @options="m", @pattern="bar">
D, [2021-04-23T10:41:02.184006 #27290] DEBUG -- : MONGODB | localhost:14920 req:17 conn:1:2 sconn:591 | admin.endSessions | STARTED | {"endSessions"=>[{"id"=><BSON::Binary:0x1960 type=uuid data=0xf2c7081370ed47b6...>}], "$db"=>"admin", "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x00005568e47fd878 @seconds=1619188862, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x1980 t...
D, [2021-04-23T10:41:02.184254 #27290] DEBUG -- : MONGODB | localhost:14920 req:17 | admin.endSessions | SUCCEEDED | 0.000s
```
