r = db.bar2.aggregate([
  {$project: {x: '$locs.0.ny', _id:0}},
])

  r.forEach(i=>{
print(JSON.stringify(i))
})
