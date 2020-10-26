r = db.foo.aggregate([
  {$match: {type: 'foo'}},
  {$lookup: {from: 'foo',as:'c',let:{
      c: '$children.id',
    },pipeline:[
      {$project: {x: '$$c', _id:0}},
  ]}},
])

r.forEach(i=>{
print(JSON.stringify(i))
})
