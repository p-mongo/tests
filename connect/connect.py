import pymongo

MONGODB_URI = 'mongodb://127.0.0.1:27017/test?replicaSet=replset'

client = pymongo.MongoClient(MONGODB_URI)
client['test']['test'].insert_one(dict(a=1))
print('inserted')
print(client.nodes)
