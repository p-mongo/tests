const MongoClient = require('mongodb').MongoClient;

const dburl='mongodb://localhost:14420'
const dbName='foo'
const collectionName='foo'
const filter={a:1}
const newData={b:2}

MongoClient.connect(dburl,{useNewUrlParser: true, useUnifiedTopology: true},function(err, db) {
var dbo = db.db(dbName);  

  if (err) throw err;
    dbo.collection(collectionName)
       .updateOne(filter, {$set:newData},{upsert:true})
       .then( result => db.close())
       .catch( err => console.log(err));
})

