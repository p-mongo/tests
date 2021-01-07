r = db.foo.aggregate([
  {$project: {foo: {$objectToArray: '$foo'}}},
  {$project: {foo: '$foo.v'}},
  {$project: {foo: {$cond: {
    if: {eq: ['cat', '$foo.bar']},
    then: '$foo.bar',
    else: '$$REMOVE',
  }}}},
  {$project: {foo: {$filter: {
    input: '$foo',
    as: 'x',
    cond: {$in: ['cat', '$$x']},
  }}}},
  {$match: {foo: {$size: 1}}},
])

r.forEach(i=>{
print(JSON.stringify(i))
})
