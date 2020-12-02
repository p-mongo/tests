var c = db['foo']
c.deleteMany({})
c.insertMany([{a:null,b:1},{a:2,b:2},{b:3},{a:4,b:4}])

e=c.aggregate([
  {$set: {a_type: {$type: '$a'}}},
  {$set: {s: {$cond: {if: {$in: ['$a_type',['null', 'missing']]}, then: 0, else: 1}}}},
  {$sort: {s: 1, a: 1}},
  {$project: {a_type: 0, s: 0}},
])
