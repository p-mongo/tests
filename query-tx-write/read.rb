require 'mongo'

client = Mongo::Client.new(['localhost:14420'], database: 'foo')

coll = client['coll']

loop do
  foo_v = coll.find.map do |doc|
    doc['foo']
  end.uniq
  if foo_v.length != 1
    p foo_v
    raise 'Oops'
  end
end
