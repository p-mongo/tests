require 'mongo'

c = Mongo::Client.new(['localhost'])
cc = c['foo']

cc.delete_many
cc.insert_many([{a: 'test'}, {arr: [a: 'test']}])

pp cc.aggregate([
  {'$match' => {'$or' => [{a: 'test'},{'arr.a'=>'test'}]}},
  {'$project'=>{a:1,arr:1,src:{
    '$switch'=>{branches:[{case:{'$eq':['$a','test']},then:'a'}],default:'arr'},
}}},
]).to_a

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
  {__project: {
    foo: {
      __filter: {
        input: '$arr.a',
        cond: {
          __regexMatch: {
            input: '$$this',
            regex: 'test',
          },
        },
      },
    },
  }},
]))).to_a

pp cc.aggregate(printing(mql([
  {__match: {
    __or: [
      {a: 'test'},
      {arr__a: 'test'},
    ],
  }},
  {__project: {
    a: 1,
    arr: 1,
    src: {
      __switch: {
        branches: [
          {
            case: {
              __regexMatch: {
                input: '$a',
                regex: 'test',
              },
            },
            then: 'a',
          },
          {
            case: {
              __gte: [
                {__size: {
                  __filter: {
                    input: '$arr.a',
                    cond: {
                      __regexMatch: {
                        input: '$$this',
                        regex: 'test',
                      },
                    },
                  },
                }},
                1,
              ],
            },
            then: 'arr.a',
          },
        ],
        default: 'def',
      },
    },
  }},
]))).to_a
