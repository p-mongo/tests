r = db.foo.aggregate([
  {$match: {type: 'foo'}},
  {$lookup: {from: 'foo',as:'c',let:{
      c_id: '$children.0.id',
    },pipeline:[
    {$match: {$expr: {$eq: ['$id', '$$c_id']}}},
  ]}},
])

r.forEach(i=>{
print(JSON.stringify(i))
})
