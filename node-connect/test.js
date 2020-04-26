const MongoClient = require('mongodb').MongoClient;

const dburl='mongodb://1.1.1.14334:14420'
const dbName='foo'
const collectionName='foo'
const filter={a:1}
const newData={b:2}

const mongoose=require('mongoose')

async function test(){
    try {
        await mongoose.connect(dburl, {
            useNewUrlParser: true,
            useUnifiedTopology: true,
            socketTimeoutMS: 1000,
            serverSelectionTimeoutMS: 1000,
        });
        console.log("accessible")
    } catch (e) {
        console.log("not accessible: " + e)
    }
  }
  test()
