const { MongoClient } = require("mongodb");

const uri = "mongodb://localhost:14070,localhost:14071/?retrywrites=false&directconnection=false"

const client = new MongoClient(uri);

async function run() {
  try {
    await client.connect();

    const database = client.db("sample_mflix");
    const collection = database.collection("movies");
    // create a document to be inserted
    const doc = { name: "Red", town: "kanto" };
    const result = await collection.insertOne(doc);

    console.log(
      `${result.insertedCount} documents were inserted with the _id: ${result.insertedId}`,
    );
  } finally {
    await client.close();
  }
}
run().catch(console.dir);
