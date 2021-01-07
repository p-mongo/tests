const { MongoClient } = require("mongodb");

const uri = "mongodb://localhost/?directconnection=false&minpoolsize=1&maxpoolsize=1000"

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();
    
    for (var i=0;i<1000;++i){
    client.db('admin').command({pingx:0}).then((res)=>{
    console.log(res)
    })
  }
  } finally {
    //await client.close();
  }
}
run().catch(console.dir);
