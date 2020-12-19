const { MongoClient } = require("mongodb");

// Replace the uri string with your MongoDB deployment's connection string.

const uri = 'mongodb://localhost:14400'

const client = new MongoClient(uri);

async function run() {

  try {

    await client.connect();
console.log()

    const database = client.db("sample_mflix");

    const c = database.collection("movies");
    
    await c.deleteMany()
    
    for (var i = 0; i < 1000; ++i) {
      await c.insertOne({counter: 10})
    }
    
    let ps=[]
    for (var i = 0; i < 10000; ++i) {
      ps.push(c.updateOne({counter: {$gt: 0}}, {$inc: {counter: -1}}))
    }
    
    for (var i in ps) {
      p=ps[i]
      p.then(()=>{})
    }
    
    await c.find({counter: {$lt: 0}}).forEach(console.dir)

  } finally {

    await client.close();

  }

}

run().catch(console.dir);
