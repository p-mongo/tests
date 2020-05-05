const mongodb = require('mongodb');

(async() => {
  const client = await mongodb.connect('mongodb://localhost:14420');
  const db = await client.db("testt");
  const session = client.startSession()

  const res =   session.withTransaction(async function() {
      return new Promise((resolve, reject) => {
        if(true) {
          console.log('true')
          resolve('laughed')
        } else {
          console.log('false')
          reject(`not laughing`);
        }
    })
  })
  console.log('result here')   //result here
  console.log(res)             //Promise { <pending> }
  console.log(await res);      //null
}) ()