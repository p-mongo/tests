package main

import (
  "context"
  "fmt"
  "log"
  "time"

  "go.mongodb.org/mongo-driver/bson"
  "go.mongodb.org/mongo-driver/mongo"
  "go.mongodb.org/mongo-driver/mongo/options"
  //  "go.mongodb.org/mongo-driver/mongo/readpref"
)

func check(err error) {
  if err != nil {
    panic(err)
  }
}

func main() {

  uri := "mongodb://localhost:14420"

  // https://stackoverflow.com/questions/24809287/how-do-you-get-a-golang-program-to-print-the-line-number-of-the-error-it-just-ca
  log.SetFlags(log.LstdFlags | log.Lshortfile)

  client, err := mongo.NewClient(options.Client().ApplyURI(uri))
  check(err)
  ctx, _ := context.WithTimeout(context.Background(), 10*time.Second)
  err = client.Connect(ctx)
  check(err)
  defer client.Disconnect(ctx)

  db := client.Database("load")
  coll := db.Collection("coll")

  count := 0
  for j := 0; j < 9000; j++ {
    cursor, err := coll.Find(ctx, bson.M{})
    check(err)
    defer cursor.Close(ctx)
    for cursor.Next(ctx) {
      var elt bson.M
      if err = cursor.Decode(&elt); err != nil {
        panic(err)
      }
      _ = elt
      count = count + 1
    }

  fmt.Printf("round %d: %d documents retrieved\n", j,count)
  }

  //err = client.Ping(ctx, readpref.SecondaryPreferred())
  fmt.Printf("finish\n")

}
