r = db.bar.aggregate([
  {$project: {x: '$locs.0', _id:0}},
])

  r.forEach(i=>{
print(JSON.stringify(i))
})
