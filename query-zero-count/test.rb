require 'mongo'

c = Mongo::Client.new(['localhost'])
cc = c['foo']

cc.delete_many
cc.insert_many([{
  a: 1,
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
  k.to_s.sub(/\A__/, '$').gsub('__', '.')
end

def printing(q)
  pp q
  q
end

pp cc.aggregate(printing(mql([
  {__match: {a: 2}},
  {__bucket: {
    groupBy: '$a',
    boundaries: [0, 1000],
    output: {
      b: {__sum: 1},
    },
  }},
]))).to_a
