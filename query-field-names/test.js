db['foo'].insert({a:{foo:{bar:{zoom:42}}},b:'c'})

mr = db.runCommand({
  "mapreduce" : "foo",
  "map" : function() {
    for (var key in this) { emit(key, null); }
  },
  "reduce" : function(key, stuff) { return null; },
  "out": "myCollectionName" + "_keys"
})


print(db[mr.result].distinct("_id"))
