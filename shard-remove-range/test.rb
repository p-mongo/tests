require 'mongo'

c = Mongo::Client.new(['localhost:14440'])

pp c.command(
  listShards: 1,
).documents.first

c.command(
  addShardToZone: 'shard01',
  zone: 'zone-1',
)

pp c.use('config')['shards'].find.to_a

c.use('foo').command(dropDatabase: 1)

cc = c.use('foo')

#cc.command(create: 'bar')

pp c.command(
  enableSharding: 'foo',
)

pp c.command(
  shardCollection: 'foo.bar',
  key: {a: 1, t: 1},
)

pp c.command(
  updateZoneKeyRange: 'foo.bar',
  min: {a: 1},
  max: {a: 2},
  zone: 'zone-1',
)

pp c.use('config')['shards'].find.to_a

cc['bar'].insert_one(a: 42, t: 43)

=begin
pp c.command(
  updateZoneKeyRange: 'foo.bar',
  min: {a: 1},
  max: {a: 2},
  zone: nil,
)
=end

pp c.use('config')['shards'].find.to_a
