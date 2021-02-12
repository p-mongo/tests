require 'mongo'

c = Mongo::Client.new(['localhost:14400'])
cc = c['foo']

cc.delete_many
cc.insert_many([{
  foo: 1,
  bar: [10, 11],
}, {
  foo: 1,
  bar: [10, 21],
}, {
  foo: 2,
  bar: [30, 31],
}])

def mql(exp)
  case exp
  when Hash
    Hash[exp.map do |k, v|
      [transform_key(k), mql(v)]
    end]
  when Array
    exp.map do |v|
      mql(v)
    end
  else
    exp
  end
end

def transform_key(k)
  k = k.to_s.sub(/\A__/, '$').gsub('__', '.')
  if k.start_with?('$')
    k = k.gsub(/(?!^)_(\w)/) { $1.upcase }
  end
  k
end

def printing(q)
  pp q
  puts
  q
end

pp cc.aggregate(printing(mql([
  { __unwind: '$bar' },
  { __group: {
    _id: '$foo',
    bar: {__add_to_set: '$bar'},
  }},
]))).to_a
