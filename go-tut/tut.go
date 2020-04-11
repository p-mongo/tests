package main

import (
  "context"
  "fmt"
  "log"
  "time"

  "go.mongodb.org/mongo-driver/bson"
  "go.mongodb.org/mongo-driver/mongo"
  "go.mongodb.org/mongo-driver/mongo/options"
  "go.mongodb.org/mongo-driver/mongo/readpref"
)

func check(err error) {
  if err != nil {
    log.Fatal(err)
  }
}

func main() {

  uri := "mongodb://localhost:14420"
  client, err := mongo.NewClient(options.Client().ApplyURI(uri))
  check(err)
  ctx, _ := context.WithTimeout(context.Background(), 10*time.Second)
  err = client.Connect(ctx)
  check(err)
  defer client.Disconnect(ctx)

  err = client.Ping(ctx, readpref.SecondaryPreferred())
  check(err)
  databases, err := client.ListDatabaseNames(ctx, bson.M{})
  check(err)
  fmt.Println(databases)

}
