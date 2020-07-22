var c = db['foo']
c.deleteMany({})
c.insert({a:[{b:{c:1,cc:11}}], d:[2]})

function e(q) {

  print()
  var r =  c.find(q)

  print(r)
  
  try {
    print(r.length())
  } catch (e) {
    print(e)
  }
}

e({a: {$elemMatch: {b: {$exists: true}}}})

e({a: {$elemMatch: {$and: [{b: {$exists: true}}]}
}})

e({d: 2})

e({d: {$elemMatch: 2}})

e({a: {$elemMatch: {$or: [
  {'b.c': {$gt: 0}},
  {'b.cc': {$gt: 20}},
  
  ]}
}})
