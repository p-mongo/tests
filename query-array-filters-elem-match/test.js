var c = db['foo']

c.deleteMany({})
c.insert({id: 1, items: [{sub: 1, v: 1},{sub: 2, v: [{q: 2},{r:2}]}]})

printjson(c.find().map(k=>k))

/*
c.updateOne({id: 1}, {$set: {'items.$[item]': 3}}, {arrayFilters: [{'item.sub': 2}]})

print('--')
printjson(c.find().map(k=>k))
*/

c.updateOne({id: 1}, {$set: {'items.$[item]': 3}}, {arrayFilters: [{'item.v': {$elemMatch:{q:2}}}]})

print('--')
printjson(c.find().map(k=>k))
