const { MongoClient } = require("mongodb");

const uri = "mongodb://localhost:14071/?retrywrites=false&directconnection=false"

const client = new MongoClient(uri,{useUnifiedTopology:true});

async function run() {
  await client.connect();

 // Prereq: Create collections.

  await client.db('mydb1').collection('foo').insertOne({ abc: 0 }, { w: 'majority' });

  await client.db('mydb2').collection('bar').insertOne({ xyz: 0 }, { w: 'majority' });

  // Step 1: Start a Client Session
  const session = client.startSession();

  // Step 2: Optional. Define options to use for the transaction
  const transactionOptions = {
    readPreference: 'primary',
    readConcern: { level: 'local' },
    writeConcern: { w: 'majority' }
  };

  // Step 3: Use withTransaction to start a transaction, execute the callback, and commit (or abort on error)
  // Note: The callback for withTransaction MUST be async and/or return a Promise.
  try {
    await session.withTransaction(async () => {
      const coll1 = client.db('mydb1').collection('foo');
      const coll2 = client.db('mydb2').collection('bar');

      // Important:: You must pass the session to the operations

      await coll1.insertOne({ abc: 1 }, { session });
      await coll2.insertOne({ xyz: 999 }, { session });
    }, transactionOptions);
  } finally {
    await session.endSession();
    await client.close();
  }
}
run().catch(console.dir);
