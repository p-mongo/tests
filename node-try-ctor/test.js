

const { MongoClient } = require("mongodb");

async function run() {
  try {
    const client = await MongoClient('mongodb://localhost:27017/testing?serverSelectionTimeoutMS=1', { useNewUrlParser: true, useUnifiedTopology: true }).connect()
    // other code
  } finally {
    await client.close()
  }
}
run().catch(error => { console.error(error) })
