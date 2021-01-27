require 'mongo'

client = Mongo::Client.new(['localhost:14420'], database: 'foo')

coll = client['coll']

loop do
  client.start_session do |s|
    s.with_transaction(read_concern: {level: 'snapshot'}) do
      docs = coll.find({}, session: s).to_a
      foo_v = docs.map do |doc|
        doc['foo']
      end.uniq
      if foo_v.length != 1
        p foo_v
        raise 'Oops'
      end
    end
  end
end
