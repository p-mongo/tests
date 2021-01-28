require 'mongo'

c = Mongo::Client.new(['localhost:14400'])
cc = c['foo']

cc.delete_many
cc.insert_many([
{
  data:"data",
  arrayA:
  [
    {
      newData:"0",
      arrayB:["something1","something2"]
    },
    {
      newData:"1",
      arrayB:["something3"]
    }

  ]

}
])

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
  puts
  q
end

pp cc.aggregate(printing(mql([
  {__set: {
    head: {__slice: ['$arrayA', 0, {__add: [{__size: '$arrayA'}, -1]}]},
    tail: {__slice: ['$arrayA', -1, 1]},
  }},
  {__set: {
    tail_b: {__concatArrays: ['$tail.0.arrayB', ['something4']]},
  }},
  {__set: {
    tail__0__arrayB: '$tail_b',
  }},
  {__set: {
    arrayA: {__concatArrays: ['$head', '$tail']},
  }},
]))).to_a
