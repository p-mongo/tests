db.foo.insert([
{ 'id': 1, name: 'bob', type: 'foo', children: [{'id': 2}, {'id': 3}]},
{ 'id': 2, name: 'bob', type: 'foo' },
{ 'id': 3, name: 'bob', type: 'bar' },
{ 'id': 4, name: 'bob', type: 'foo', children: [{'id': 5}, {'id': 6}]},
{ 'id': 5, name: 'bob', type: 'foo' },
{ 'id': 6, name: 'bob', type: 'foo' },
])

db.bar.insert([
{_id: 1, locs: ['ny']},
])

db.bar2.insert([
{_id: 1, locs: [{ny:42}]},
])
