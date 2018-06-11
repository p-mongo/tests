// Tested on node 9
// Create indices on the test collection in mongo shell:
// db.test.createIndex({w: 1})
// db.test.createIndex({i: 1})
// Force GC runs throughout the test: node --expose-gc transfer_rate.js

const MongoClient = require('mongodb').MongoClient;
const assert = require('assert');

const url = process.env.MONGODB_URI || 'mongodb://localhost:27017';
const itercount = parseInt(process.env.ITER_COUNT || 300)

const dbName = 'test';

var a = [];
for (var i = 0; i < 1500000; ++i) {
  a.push('bbbbbbbbbb');
}
base = a.join('')

function data(length) {
  let d = base
  for (var i = 0; i < length; ++i) {
    d += 'x'
  }
  return d
}

let p = MongoClient.connect(url)
.then(function(client) {
  console.log("Connected successfully to server");

  this.client = client
  this.db = client.db(dbName);
  this.collection = this.db.collection('test');
  
  return this.collection.deleteMany()
}.bind(this))

p = p.then(function() {
  console.log('Warming up')
})
for (var i = 0; i < itercount/5; ++i) {
  let j = i
  p = p.then(function() {
    return this.collection.insert({w: j, d: data(j)})
  }.bind(this))
}

p = p.then(function() {
  console.log('Benchmarking write')
  this.start = new Date
}.bind(this))

for (var i = 0; i < itercount; ++i) {
  let j = i
  p = p.then(function() {
    return this.collection.insert({i: j, d: data(j)})
  }.bind(this))
}

p = p.then(function() {
  var elapsed = new Date - this.start
  console.log(itercount * 1000 / elapsed + ' inserts/second')
  
  console.log('Warming up')
}.bind(this))

for (var i = 0; i < itercount/5; ++i) {
  let j = i
  p = p.then(function() {
    return this.collection.find({w: j}).toArray()
  }.bind(this))
}

p = p.then(function() {
  if (global.gc) {
    console.log('GC')
    global.gc()
  }
  
  console.log('Benchmarking read')
  this.start = new Date
}.bind(this))

for (var i = 0; i < itercount; ++i) {
  let j = i
  p = p.then(function() {
    if (j % 10 == 9 && global.gc) {
      console.log('GC')
      global.gc()
    }
    return this.collection.find({i: j}).toArray()
  }.bind(this))
}

p = p.then(function() {
  var elapsed = new Date - this.start
  console.log(itercount * 1000 / elapsed + ' finds/second')
  this.client.close()
}.bind(this))
.catch(function(err) {
  console.log(err);
})

// Benchmarking in mongo shell:
// This performs the transfer:
// > s=new Date;db.test.findOne({i:201}).d.length; new Date-s
// This does not:
// > s=new Date;db.test.findOne({i:201}); new Date-s
