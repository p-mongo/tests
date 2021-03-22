#!/bin/sh

set -e

export PATH=/usr/local/m/versions/4.2:$PATH
root=/mnt/zram/sandbox/ss

pkill mongod || true
pkill mongos || true
sleep 1

rm -rf "$root"
mkdir -p $root

params="--setParameter honorSystemUmask=true"

mkdir $root/cs
mongod --configsvr --replSet cs --dbpath $root/cs --bind_ip 127.2.0.6 --logpath $root/cs/mongod.log --fork $params
mongo 'mongodb://127.2.0.6:27019/?serverSelectionTimeoutMS=30000' <<-EOT
  rs.initiate({_id: 'cs', configsvr: true, members: [
    {_id: 0, host: '127.2.0.6:27019'}]})
EOT

mkdir $root/s1-1
mongod --shardsvr --replSet s1 --dbpath $root/s1-1 --bind_ip 127.2.0.3 --logpath $root/s1-1/mongod.log --fork $params

mkdir $root/s1-2
mongod --shardsvr --replSet s1 --dbpath $root/s1-2 --bind_ip 127.2.0.4 --logpath $root/s1-2/mongod.log --fork $params

mkdir $root/s1-3
mongod --shardsvr --replSet s1 --dbpath $root/s1-3 --bind_ip 127.2.0.5 --logpath $root/s1-3/mongod.log --fork $params

mongo 'mongodb://127.2.0.3:27018/?serverSelectionTimeoutMS=30000' <<-EOT
  rs.initiate({_id: 's1', members: [
    {_id: 3, host: '127.2.0.3:27018'},{_id: 4, host: '127.2.0.4:27018'},{_id: 5, host: '127.2.0.5:27018'}
  ]})
EOT

mkdir $root/s1
mongos --configdb cs/127.2.0.6:27019 --bind_ip 127.2.0.2  --logpath $root/s1/mongos.log --fork $params

mongo 'mongodb://127.2.0.2/?serverSelectionTimeoutMS=30000' <<-EOT
  sh.addShard("s1/127.2.0.3:27018,127.2.0.4:27018,127.2.0.5:27018")
EOT
