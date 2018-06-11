import os
import time as _time
import pymongo

print('Connecting...')
iter_count = int(dict(os.environ).get('ITER_COUNT', 300))
client = pymongo.MongoClient(dict(os.environ).get('MONGODB_URI', '127.0.0.1:27017'))

db = client['test']
collection = db['test']

collection.delete_many(dict())

print('Warming up...')
for i in range(iter_count/5):
    collection.insert_one(dict(i=i, data='x' * (1000000 + i)))

print('Benchmarking write...')
start = _time.time()
for i in range(iter_count):
    collection.insert_one(dict(i=i, data='x' * (1000000 + i)))
t = _time.time() - start
print("%.2f inserts/second" % (float(iter_count) / t))

print("Warming up...")
for i in range(iter_count/5):
    collection.find_one(dict(i=i))

print("Benchmarking read...")
start = _time.time()
for i in range(iter_count):
    collection.find_one(dict(i=i))
t = _time.time() - start
print("%.2f reads/second" % (float(iter_count) / t))
