# Shard Distribution Test

Using a hashed shard key evenly distributes documents across shards.

## Result

    MongoDB Enterprise mongos> db.data.getShardDistribution()

    Shard shard01 at shard01/localhost:27301,localhost:27302,localhost:27303
     data : 339.79MiB docs : 34971 chunks : 14
     estimated data per chunk : 24.27MiB
     estimated docs per chunk : 2497

    Shard shard03 at shard03/localhost:27307,localhost:27308,localhost:27309
     data : 333.01MiB docs : 34270 chunks : 14
     estimated data per chunk : 23.78MiB
     estimated docs per chunk : 2447

    Shard shard02 at shard02/localhost:27304,localhost:27305,localhost:27306
     data : 337.16MiB docs : 34699 chunks : 14
     estimated data per chunk : 24.08MiB
     estimated docs per chunk : 2478

    Shard shard04 at shard04/localhost:27310,localhost:27311,localhost:27312
     data : 340.67MiB docs : 35060 chunks : 14
     estimated data per chunk : 24.33MiB
     estimated docs per chunk : 2504

    Totals
     data : 1.31GiB docs : 139000 chunks : 56
     Shard shard01 contains 25.15% data, 25.15% docs in cluster, avg obj size on shard : 9KiB
     Shard shard03 contains 24.65% data, 24.65% docs in cluster, avg obj size on shard : 9KiB
     Shard shard02 contains 24.96% data, 24.96% docs in cluster, avg obj size on shard : 9KiB
     Shard shard04 contains 25.22% data, 25.22% docs in cluster, avg obj size on shard : 9KiB
