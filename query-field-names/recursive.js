db['foo'].deleteMany({})
db['foo'].insert({a:{foo:{bar:{zoom:42}}},b:'c',d:'e',x:[]})

mr = db.runCommand({
  "mapreduce" : "foo",
  "map" : function() {
    var f = function() {
      for (var key in this) {
        if (this.hasOwnProperty(key)) {
          emit(key, null)
          if (typeof this[key] == 'object') {
            f.call(this[key])
          }
        }
      }
    }
    f.call(this);
  },
  "reduce" : function(key, stuff) { return null; },
  "out": "myCollectionName" + "_keys"
})


print(db[mr.result].distinct("_id"))
