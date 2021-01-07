

import csv
import sqlite3
import pymongo, random, time

N, M = 1000000, 5
docs = [{'_id':1,'b':2,'c':3,'d':4,'e':5}]*N
i=1
for i in range(len(docs)):
    docs[i]=dict(docs[i])
    docs[i]['_id'] = i
data=[tuple(doc.values())for doc in docs]

with open('test.csv', 'w', newline='') as file:
    writer = csv.writer(file, delimiter=',')
    start = time.time()
    for i in range(N):
        writer.writerow(data[i])
    end = time.time()
    print('%f' %( end-start))


con = sqlite3.connect('test.db')
con.execute('drop table if exists five')
con.execute('create table five(a, b, c, d, e)')
start = time.time()
con.executemany('insert into five(a, b, c, d, e) values (?,?,?,?,?)', data)


end = time.time()
print('%f' %( end-start))



with pymongo.MongoClient() as client:
  client['warmup']['warmup'].delete_many({})
  client['test']['test'].delete_many({})
  client['warmup']['warmup'].insert_many(docs)
  db = client['test']
  coll = db['test']
  start = time.time()
  coll.insert_many(docs)
  end = time.time()
print('%f' %( end-start))
