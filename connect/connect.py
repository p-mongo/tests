# This test is meant to have a replica set configured at localhost:27017,
# localhost:27018, localhost:27019 as started by e.g.
# mlaunch --replset.
# The test is for hostname/IP mismatch in seed address given to client.

import pymongo

MONGODB_URI = 'mongodb://127.0.0.1:27017/test?replicaSet=replset'

client = pymongo.MongoClient(MONGODB_URI)
client['test']['test'].insert_one(dict(a=1))
print('inserted')
print(client.nodes)
