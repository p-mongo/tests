# Secondary read result

Client log excerpt:

    D, [2019-10-10T20:59:57.865595 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionCheckOutStarted address=localhost:30200>
    D, [2019-10-10T20:59:57.865665 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionCheckedOut address=localhost:30200 connection_id=2 pool=0x47434753605560>
    D, [2019-10-10T20:59:57.866032 #2431] DEBUG -- : MONGODB | [4056] localhost:30200 #2 | admin.find | STARTED | {"find"=>"test-collection", "filter"=>{"a"=>"1570755597.865305"}, "$readPreference"=>{"mode"=>"secondary"}, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x0000564887441f80 @seconds=1570755578, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x...
    D, [2019-10-10T20:59:57.866268 #2431] DEBUG -- : MONGODB | [4056] localhost:30200 | admin.find | FAILED | EOFError: end of file reached (for 127.0.0.1:30200 (no TLS)) | 0.000100826s
    D, [2019-10-10T20:59:57.866440 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionClosed address=localhost:30200 connection_id=2 reason=error>
    D, [2019-10-10T20:59:57.866692 #2431] DEBUG -- : MONGODB | EVENT: #<ServerDescriptionChanged address=localhost:30200 topology=ReplicaSetNoPrimary[localhost:30200,localhost:30201,localhost:30202,name=ruby-driver-rs,v=1,e=7fffffff0000000000000017] prev=#<Mongo::Server:Description:0x47434755287940 config={"hosts"=>["localhost:30200", "localhost:30201", "localhost:30202"], "setName"=>"ruby-driver-rs", "setVersion"=>1, "ismaster"=>false, "secondary"=>true, "me"=>"localhost:30200", "lastWrite"=>{"opTime"=>{"ts"=>#<BSON::Timestamp:0x00005648877a6298 @seconds=1570755578, @increment=1>, "t"=>23}, "lastWriteDate"=>2019-10-11 00:59:38 UTC, "majorityOpTime"=>{"ts"=>#<BSON::Timestamp:0x00005648877a6068 @seconds=1570755568, @increment=1>, "t"=>22}, "majorityWriteDate"=>2019-10-11 00:59:28 UTC}, "maxBsonObjectSize"=>16777216, "maxMessageSizeBytes"=>48000000, "maxWriteBatchSize"=>100000, "localTime"=>2019-10-11 00:59:57 UTC, "logicalSessionTimeoutMinutes"=>30, "connectionId"=>18, "minWireVersion"=>0, "maxWireVersion"=>8, "readOnly"=>false, "ok"=>1.0, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x00005648877a59b0 @seconds=1570755578, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x47434755288120 type=generic data=0x0000000000000000...>, "keyId"=>0}}, "operationTime"=>#<BSON::Timestamp:0x00005648877a57f8 @seconds=1570755578, @increment=1>} average_round_trip_time=0.009605613429056003> new=#<Mongo::Server:Description:0x47434755585900 config={} average_round_trip_time=>>
    D, [2019-10-10T20:59:57.866747 #2431] DEBUG -- : MONGODB | Server description for localhost:30200 changed from 'secondary' to 'unknown'.
    D, [2019-10-10T20:59:57.866874 #2431] DEBUG -- : MONGODB | EVENT: #<TopologyChanged prev=ReplicaSetNoPrimary[localhost:30200,localhost:30201,localhost:30202,name=ruby-driver-rs,v=1,e=7fffffff0000000000000017] new=ReplicaSetNoPrimary[localhost:30200,localhost:30201,localhost:30202,name=ruby-driver-rs,v=1,e=7fffffff0000000000000017]>
    D, [2019-10-10T20:59:57.866933 #2431] DEBUG -- : MONGODB | Topology type 'ReplicaSetNoPrimary' changed to type 'ReplicaSetNoPrimary'.
    D, [2019-10-10T20:59:57.866988 #2431] DEBUG -- : MONGODB | EVENT: #<PoolCleared address=localhost:30200>
    D, [2019-10-10T20:59:57.867261 #2431] DEBUG -- : MONGODB | [4055] localhost:30200 | admin.find | FAILED | EOFError: end of file reached (for 127.0.0.1:30200 (no TLS)) | 0.002506365s
    D, [2019-10-10T20:59:57.867460 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionClosed address=localhost:30200 connection_id=5 reason=error>
    D, [2019-10-10T20:59:57.867540 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionClosed address=localhost:30200 connection_id=4 reason=stale>
    D, [2019-10-10T20:59:57.867609 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionClosed address=localhost:30200 connection_id=1 reason=stale>
    D, [2019-10-10T20:59:57.867666 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionClosed address=localhost:30200 connection_id=3 reason=stale>
    D, [2019-10-10T20:59:57.867727 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionCheckedIn address=localhost:30200 connection_id=2 pool=0x47434753605560>
    D, [2019-10-10T20:59:57.868106 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionCheckedIn address=localhost:30200 connection_id=5 pool=0x47434753605560>
    D, [2019-10-10T20:59:57.868331 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionCheckOutStarted address=localhost:30201>
    D, [2019-10-10T20:59:57.868403 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionCheckedOut address=localhost:30201 connection_id=2 pool=0x47434753514980>
    D, [2019-10-10T20:59:57.868771 #2431] DEBUG -- : MONGODB | [4057] localhost:30201 #2 | admin.find | STARTED | {"find"=>"test-collection", "filter"=>{"a"=>"1570755597.865305"}, "$readPreference"=>{"mode"=>"secondary"}, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x0000564887441f80 @seconds=1570755578, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0x...
    D, [2019-10-10T20:59:57.869011 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionCheckOutStarted address=localhost:30202>
    D, [2019-10-10T20:59:57.869095 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionCheckedOut address=localhost:30202 connection_id=2 pool=0x47434753556400>
    D, [2019-10-10T20:59:57.869487 #2431] DEBUG -- : MONGODB | [4058] localhost:30202 #2 | admin.find | STARTED | {"find"=>"test-collection", "filter"=>{"a"=>"1570755597.8637643"}, "$readPreference"=>{"mode"=>"secondary"}, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x0000564887441f80 @seconds=1570755578, @increment=1>, "signature"=>{"hash"=><BSON::Binary:0...
    D, [2019-10-10T20:59:57.869776 #2431] DEBUG -- : MONGODB | [4057] localhost:30201 | admin.find | SUCCEEDED | 0.001s
    D, [2019-10-10T20:59:57.869836 #2431] DEBUG -- : MONGODB | EVENT: #<ConnectionCheckedIn address=localhost:30201 connection_id=2 pool=0x47434753514980>

This shows:

- Command logging for initial attempt and retry. The timestamp in the filter
is unique for each operation - the 4056 and 4057 operations are part of
executing the same application operation.
- First operation failing.
- Connection for the first operation being closed due to the error.
- Connection pool being cleared.
- Server being marked unknown.
- Retry being dispatched to another server.
- Connection being checked out of the pool for the second server.
- Retry succeeding.
