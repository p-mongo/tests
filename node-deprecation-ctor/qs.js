const { MongoClient } = require("mongodb");
// Replace the uri string with your MongoDB deployment's connection string.
const uri = 'mongodb://localhost:14400'
console.log('instantiate')
const client = new MongoClient(uri);
console.log('done')
async function run() {
  try {
    await client.connect();
    console.log('connected')
    const database = client.db('sample_mflix');
    const collection = database.collection('movies');
    // Query for a movie that has the title 'Back to the Future'
    const query = { title: 'Back to the Future' };
    const movie = await collection.findOne(query);
    console.log(movie);
  } finally {
    // Ensures that the client will close when you finish/error
    await client.close();
  }
}
run().catch(console.dir);
