Collection scan: 0.7510360386222601 seconds
Count scan: 0.8630566261708736 seconds

```
serene2% ruby count.rb
D, [2022-08-08T10:49:01.091917 #30283] DEBUG -- : MONGODB | Topology type 'unknown' initializing.
D, [2022-08-08T10:49:01.092083 #30283] DEBUG -- : MONGODB | There was a change in the members of the 'Unknown' topology.
D, [2022-08-08T10:49:01.092193 #30283] DEBUG -- : MONGODB | Server localhost:14400 initializing.
D, [2022-08-08T10:49:01.092306 #30283] DEBUG -- : MONGODB | Waiting for up to 30.00 seconds for servers to be scanned: #<Cluster topology=Unknown[localhost:14400] servers=[#<Server address=localhost:14400 UNKNOWN>]>
D, [2022-08-08T10:49:01.093598 #30283] DEBUG -- : MONGODB | Server description for localhost:14400 changed from 'unknown' to 'standalone'.
D, [2022-08-08T10:49:01.093791 #30283] DEBUG -- : MONGODB | Topology type 'Unknown' changed to type 'Single'.
D, [2022-08-08T10:49:01.095479 #30283] DEBUG -- : MONGODB | localhost:14400 req:6 conn:1:1 sconn:965 | admin.count | STARTED | {"count"=>"foo", "query"=>{}, "$db"=>"admin", "lsid"=>{"id"=><BSON::Binary:0x780 type=uuid data=0x2ce76cb294cd4858...>}}
D, [2022-08-08T10:49:01.095724 #30283] DEBUG -- : MONGODB | localhost:14400 req:6 | admin.count | SUCCEEDED | 0.000s
0.0017840862274169922
D, [2022-08-08T10:49:01.096101 #30283] DEBUG -- : MONGODB | localhost:14400 req:7 conn:1:1 sconn:965 | admin.count | STARTED | {"count"=>"foo", "$db"=>"admin", "lsid"=>{"id"=><BSON::Binary:0x780 type=uuid data=0x2ce76cb294cd4858...>}}
D, [2022-08-08T10:49:01.096368 #30283] DEBUG -- : MONGODB | localhost:14400 req:7 | admin.count | SUCCEEDED | 0.000s
0.0005793608725070953
D, [2022-08-08T10:49:01.096825 #30283] DEBUG -- : MONGODB | localhost:14400 req:8 conn:1:1 sconn:965 | admin.aggregate | STARTED | {"aggregate"=>"foo", "pipeline"=>[{"$match"=>{}}, {"$group"=>{"_id"=>1, "n"=>{"$sum"=>1}}}], "cursor"=>{}, "$db"=>"admin", "lsid"=>{"id"=><BSON::Binary:0x780 type=uuid data=0x2ce76cb294cd4858...>}}
D, [2022-08-08T10:49:01.880413 #30283] DEBUG -- : MONGODB | localhost:14400 req:8 | admin.aggregate | SUCCEEDED | 0.783s
0.7841749023646116
D, [2022-08-08T10:49:01.881026 #30283] DEBUG -- : MONGODB | localhost:14400 req:9 conn:1:1 sconn:965 | admin.aggregate | STARTED | {"aggregate"=>"foo", "pipeline"=>[{"$match"=>{}}, {"$group"=>{"_id"=>1, "n"=>{"$sum"=>1}}}], "cursor"=>{}, "explain"=>true, "$db"=>"admin", "lsid"=>{"id"=><BSON::Binary:0x780 type=uuid data=0x2ce76cb294cd4858...>}}
D, [2022-08-08T10:49:01.881380 #30283] DEBUG -- : MONGODB | localhost:14400 req:9 | admin.aggregate | SUCCEEDED | 0.000s
{"$cursor"=>
  {"queryPlanner"=>
    {"plannerVersion"=>1,
     "namespace"=>"admin.foo",
     "indexFilterSet"=>false,
     "parsedQuery"=>{},
     "queryHash"=>"8B3D4AB8",
     "planCacheKey"=>"8B3D4AB8",
     "winningPlan"=>{"stage"=>"COLLSCAN", "direction"=>"forward"},
     "rejectedPlans"=>[]}}}
D, [2022-08-08T10:49:01.883109 #30283] DEBUG -- : MONGODB | localhost:14400 req:10 conn:1:1 sconn:965 | admin.aggregate | STARTED | {"aggregate"=>"foo", "pipeline"=>[{"$match"=>{}}, {"$group"=>{"_id"=>nil, "n"=>{"$sum"=>1}}}], "cursor"=>{}, "explain"=>true, "$db"=>"admin", "lsid"=>{"id"=><BSON::Binary:0x780 type=uuid data=0x2ce76cb294cd4858...>}}
D, [2022-08-08T10:49:01.883405 #30283] DEBUG -- : MONGODB | localhost:14400 req:10 | admin.aggregate | SUCCEEDED | 0.000s
{"$cursor"=>
  {"queryPlanner"=>
    {"plannerVersion"=>1,
     "namespace"=>"admin.foo",
     "indexFilterSet"=>false,
     "parsedQuery"=>{},
     "queryHash"=>"8B3D4AB8",
     "planCacheKey"=>"8B3D4AB8",
     "winningPlan"=>{"stage"=>"COLLSCAN", "direction"=>"forward"},
     "rejectedPlans"=>[]}}}
D, [2022-08-08T10:49:01.886815 #30283] DEBUG -- : MONGODB | localhost:14400 req:11 conn:1:1 sconn:965 | admin.aggregate | STARTED | {"aggregate"=>"foo", "pipeline"=>[{"$match"=>{}}, {"$group"=>{"_id"=>nil, "n"=>{"$sum"=>1}}}], "cursor"=>{}, "$db"=>"admin", "lsid"=>{"id"=><BSON::Binary:0x780 type=uuid data=0x2ce76cb294cd4858...>}}
D, [2022-08-08T10:49:02.637289 #30283] DEBUG -- : MONGODB | localhost:14400 req:11 | admin.aggregate | SUCCEEDED | 0.750s
0.7510360386222601
D, [2022-08-08T10:49:02.637859 #30283] DEBUG -- : MONGODB | localhost:14400 req:12 conn:1:1 sconn:965 | admin.aggregate | STARTED | {"aggregate"=>"foo", "pipeline"=>[{"$sort"=>{"_id"=>1}}, {"$group"=>{"_id"=>nil, "n"=>{"$sum"=>1}}}], "cursor"=>{}, "explain"=>true, "$db"=>"admin", "lsid"=>{"id"=><BSON::Binary:0x780 type=uuid data=0x2ce76cb294cd4858...>}}
D, [2022-08-08T10:49:02.638253 #30283] DEBUG -- : MONGODB | localhost:14400 req:12 | admin.aggregate | SUCCEEDED | 0.000s
{"$cursor"=>
  {"queryPlanner"=>
    {"plannerVersion"=>1,
     "namespace"=>"admin.foo",
     "indexFilterSet"=>false,
     "parsedQuery"=>{},
     "queryHash"=>"F44244FE",
     "planCacheKey"=>"F44244FE",
     "winningPlan"=>
      {"stage"=>"COUNT_SCAN",
       "keyPattern"=>{"_id"=>1},
       "indexName"=>"_id_",
       "isMultiKey"=>false,
       "multiKeyPaths"=>{"_id"=>[]},
       "isUnique"=>true,
       "isSparse"=>false,
       "isPartial"=>false,
       "indexVersion"=>2,
       "indexBounds"=>
        {"startKey"=>{"_id"=>#<BSON::MinKey:0x00007f05de76ab48>},
         "startKeyInclusive"=>true,
         "endKey"=>{"_id"=>#<BSON::MaxKey:0x00007f05de769db0>},
         "endKeyInclusive"=>true}},
     "rejectedPlans"=>[]}}}
D, [2022-08-08T10:49:02.640141 #30283] DEBUG -- : MONGODB | localhost:14400 req:13 conn:1:1 sconn:965 | admin.aggregate | STARTED | {"aggregate"=>"foo", "pipeline"=>[{"$sort"=>{"_id"=>1}}, {"$group"=>{"_id"=>nil, "n"=>{"$sum"=>1}}}], "cursor"=>{}, "$db"=>"admin", "lsid"=>{"id"=><BSON::Binary:0x780 type=uuid data=0x2ce76cb294cd4858...>}}
D, [2022-08-08T10:49:03.502719 #30283] DEBUG -- : MONGODB | localhost:14400 req:13 | admin.aggregate | SUCCEEDED | 0.862s
0.8630566261708736
serene2% 
```
