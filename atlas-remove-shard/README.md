# Atlas global clusters shard addition/removal

1. Use `bundle exec create.rb` to create a cluster.
2. Use `bundle exec insert.rb` to insert test data (possibly optional).
3. Use `bundle exec update.rb` to update the cluster to configuration 4.

Other tools:

- Use `bundle exec delete.rb` to delete the inserted test data.
- Edit `update.rb` to update to other configurations (2 or 3).

With config2.yml:

    I, [2020-09-16T17:37:15.219106 #3404]  INFO -- : GET https://cloud.mongodb.com/api/atlas/v1.0/groups/5f49cd4b6d8c874ca774824f/clusters
    D, [2020-09-16T17:37:15.219245 #3404] DEBUG -- : "Authorization: Digest username=\"GPVMAVJU\", realm=\"MMS Public API\", algorithm=MD5, qop=auth, uri=\"/api/atlas/v1.0/groups/5f49cd4b6d8c874ca774824f/clusters\", nonce=\"KH/OhqdP2odTM+XgFxGQDGNNAqpCQe6u\", nc=00000002, cnonce=\"68aec4c2c4f628c3637827259a6e9d59\", response=\"2aa84c4b8bdba6c032fd36f145709698\"\nuser-agent: MongoCloudClient\n\n"
    I, [2020-09-16T17:37:15.307835 #3404]  INFO -- : HTTP 200
    D, [2020-09-16T17:37:15.308121 #3404] DEBUG -- : "content-length: 843\ncontent-type: application/json\ndate: Wed, 16 Sep 2020 21:37:15 GMT\nstrict-transport-security: max-age=31536000\nvary: Accept-Encoding, User-Agent\nx-frame-options: DENY\nx-mongodb-service-version: gitHash=9aedcdd32aedfaeaa00c4509184ea76da2ee0f95; versionString=v20200901\n\n{\"links\":[{\"href\":\"https://cloud.mongodb.com/api/atlas/v1.0/groups/5f49cd4b6d8c874ca774824f/clusters?pageNum=1&itemsPerPage=100\",\"rel\":\"self\"}],\"results\":[{\"autoScaling\":{\"compute\":{\"enabled\":false,\"scaleDownEnabled\":false},\"diskGBEnabled\":true},\"backupEnabled\":false,\"biConnector\":{\"enabled\":false,\"readPreference\":\"secondary\"},\"clusterType\":\"REPLICASET\",\"connectionStrings\":{\"standardSrv\":\"mongodb+srv://oleg-test-585.zjgzi.mongodb.net\",\"standard\":\"mongodb://oleg-test-585-shard-00-00.zjgzi.mongodb.net:27017,oleg-test-585-shard-00-01.zjgzi.mongodb.net:27017,oleg-test-585-shard-00-02.zjgzi.mongodb.net:27017/?ssl=true&authSource=admin&replicaSet=atlas-51fpbe-shard-0\"},\"diskSizeGB\":10.0,\"encryptionAtRestProvider\":\"NONE\",\"groupId\":\"5f49cd4b6d8c874ca774824f\",\"id\":\"5f627fac8242981d5903cafa\",\"labels\":[],\"mongoDBMajorVersion\":\"4.2\",\"mongoDBVersion\":\"4.2.9\",\"mongoURI\":\"mongodb://oleg-test-585-shard-00-00.zjgzi.mongodb.net:27017,oleg-test-585-shard-00-01.zjgzi.mongodb.net:27017,oleg-test-585-shard-00-02.zjgzi.mongodb.net:27017\",\"mongoURIUpdated\":\"2020-09-16T21:21:39Z\",\"mongoURIWithOptions\":\"mongodb://oleg-test-585-shard-00-00.zjgzi.mongodb.net:27017,oleg-test-585-shard-00-01.zjgzi.mongodb.net:27017,oleg-test-585-shard-00-02.zjgzi.mongodb.net:27017/?ssl=true&authSource=admin&replicaSet=atlas-51fpbe-shard-0\",\"name\":\"oleg-test-585\",\"numShards\":1,\"paused\":false,\"pitEnabled\":false,\"providerBackupEnabled\":false,\"providerSettings\":{\"providerName\":\"AWS\",\"autoScaling\":{\"compute\":{\"maxInstanceSize\":null,\"minInstanceSize\":null}},\"diskIOPS\":100,\"encryptEBSVolume\":true,\"instanceSizeName\":\"M10\",\"volumeType\":\"STANDARD\"},\"replicationSpec\":{\"US_EAST_1\":{\"analyticsNodes\":0,\"electableNodes\":1,\"priority\":7,\"readOnlyNodes\":0},\"US_EAST_2\":{\"analyticsNodes\":0,\"electableNodes\":1,\"priority\":5,\"readOnlyNodes\":0},\"US_WEST_1\":{\"analyticsNodes\":0,\"electableNodes\":1,\"priority\":6,\"readOnlyNodes\":0}},\"replicationSpecs\":[{\"id\":\"5f627fac8242981d5903caf3\",\"numShards\":1,\"regionsConfig\":{\"US_EAST_1\":{\"analyticsNodes\":0,\"electableNodes\":1,\"priority\":7,\"readOnlyNodes\":0},\"US_EAST_2\":{\"analyticsNodes\":0,\"electableNodes\":1,\"priority\":5,\"readOnlyNodes\":0},\"US_WEST_1\":{\"analyticsNodes\":0,\"electableNodes\":1,\"priority\":6,\"readOnlyNodes\":0}},\"zoneName\":\"Zone 1\"}],\"srvAddress\":\"mongodb+srv://oleg-test-585.zjgzi.mongodb.net\",\"stateName\":\"IDLE\",\"links\":[{\"href\":\"https://cloud.mongodb.com/api/atlas/v1.0/groups/5f49cd4b6d8c874ca774824f/clusters/oleg-test-585\",\"rel\":\"self\"},{\"href\":\"https://cloud.mongodb.com/api/atlas/v1.0/groups/5f49cd4b6d8c874ca774824f/clusters/oleg-test-585/restoreJobs\",\"rel\":\"http://mms.mongodb.com/restoreJobs\"},{\"href\":\"https://cloud.mongodb.com/api/atlas/v1.0/groups/5f49cd4b6d8c874ca774824f/clusters/oleg-test-585/snapshots\",\"rel\":\"http://mms.mongodb.com/snapshots\"}]}],\"totalCount\":1}"
    "Using cluster oleg-test-585"
    {"clusterType"=>"REPLICASET",
     "providerSettings"=>
      {"providerName"=>"AWS",
       "regionName"=>"US_WEST_1",
       "instanceSizeName"=>"M10"},
     "replicationSpecs"=>
      [{"numShards"=>1,
        "regionsConfig"=>
         {"US_WEST_1"=>{"electableNodes"=>1, "priority"=>6, "readOnlyNodes"=>0},
          "US_EAST_1"=>{"electableNodes"=>1, "priority"=>5, "readOnlyNodes"=>0},
          "US_WEST_2"=>{"electableNodes"=>1, "priority"=>7, "readOnlyNodes"=>0}}}]}
    /home/w/apps/mcloud/lib/mongo_cloud/client.rb:101: warning: URI.escape is obsolete
    /home/w/apps/mcloud/lib/mongo_cloud/client.rb:101: warning: URI.escape is obsolete
    Sending payload: {"clusterType":"REPLICASET","providerSettings":{"providerName":"AWS","regionName":"US_WEST_1","instanceSizeName":"M10"},"replicationSpecs":[{"numShards":1,"regionsConfig":{"US_WEST_1":{"electableNodes":1,"priority":6,"readOnlyNodes":0},"US_EAST_1":{"electableNodes":1,"priority":5,"readOnlyNodes":0},"US_WEST_2":{"electableNodes":1,"priority":7,"readOnlyNodes":0}}}]} for groups/5f49cd4b6d8c874ca774824f/clusters/oleg-test-585
    I, [2020-09-16T17:37:15.320234 #3404]  INFO -- : PATCH https://cloud.mongodb.com/api/atlas/v1.0/groups/5f49cd4b6d8c874ca774824f/clusters/oleg-test-585
    D, [2020-09-16T17:37:15.320301 #3404] DEBUG -- : "Authorization: Digest username=\"GPVMAVJU\", realm=\"MMS Public API\", algorithm=MD5, qop=auth, uri=\"/api/atlas/v1.0/groups/5f49cd4b6d8c874ca774824f/clusters/oleg-test-585\", nonce=\"KH/OhqdP2odTM+XgFxGQDGNNAqpCQe6u\", nc=00000003, cnonce=\"e8432d179e02e89bb3b419481d040da0\", response=\"05d79349795242d8dd36869de1432d09\"\ncontent-type: application/json\nuser-agent: MongoCloudClient\n\n{\"clusterType\":\"REPLICASET\",\"providerSettings\":{\"providerName\":\"AWS\",\"regionName\":\"US_WEST_1\",\"instanceSizeName\":\"M10\"},\"replicationSpecs\":[{\"numShards\":1,\"regionsConfig\":{\"US_WEST_1\":{\"electableNodes\":1,\"priority\":6,\"readOnlyNodes\":0},\"US_EAST_1\":{\"electableNodes\":1,\"priority\":5,\"readOnlyNodes\":0},\"US_WEST_2\":{\"electableNodes\":1,\"priority\":7,\"readOnlyNodes\":0}}}]}"
    W, [2020-09-16T17:37:15.583185 #3404]  WARN -- : HTTP 400
    D, [2020-09-16T17:37:15.583375 #3404] DEBUG -- : "connection: close\ncontent-length: 232\ncontent-type: application/json\ndate: Wed, 16 Sep 2020 21:37:15 GMT\nstrict-transport-security: max-age=31536000\nx-frame-options: DENY\nx-mongodb-service-version: gitHash=9aedcdd32aedfaeaa00c4509184ea76da2ee0f95; versionString=v20200901\n\n{\"detail\":\"One or more shards are being removed that consume more disk space than that available on the remaining shards.\",\"error\":400,\"errorCode\":\"INSUFFICIENT_DISK_SPACE_ON_REMAINING_SHARDS\",\"parameters\":[],\"reason\":\"Bad Request\"}"
    Traceback (most recent call last):
            3: from update.rb:18:in `<main>'
            2: from /home/w/apps/mcloud/lib/mongo_cloud/client.rb:101:in `update_cluster'
            1: from /home/w/apps/mcloud/lib/mongo_cloud/client.rb:203:in `request_json'
    /home/w/apps/mcloud/lib/mongo_cloud/client.rb:255:in `request': MongoCloud PATCH groups/5f49cd4b6d8c874ca774824f/clusters/oleg-test-585 failed: 400: 400: One or more shards are being removed that consume more disk space than that available on the remaining shards. (MongoCloud::Client::BadRequest)
