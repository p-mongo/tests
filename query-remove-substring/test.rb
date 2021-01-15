require 'mongo'

c = Mongo::Client.new(['localhost'])
cc = c['foo']

cc.delete_many
cc.insert_many([{
      "images": [
        {
          id: 1,
          url: "https://stackoverflow.com/questions/ask.png"
        },
        {
          id: 2,
          url: "https://stackoverflow.com/questions/ask100?=view.png"
        },
        {
          id: 3,
          url: "https://stackoverflow.com/questions/ask101.png.png"
        }
      ]
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
  {
    __project: {
      id: 1,
      urls: {
        __map: {
          input: '$images.url',
          in: {
            __arrayElemAt: [
              {__split: [
                '$$this',
                '.png',
              ]},
              0,
            ],
          },
        },
      },
    },
  },
]))).to_a

pp cc.aggregate(printing(mql([
  {
    __set: {
      images: {
        __map: {
          input: '$images',
          in: {
            __mergeObjects: [
              '$$this',
              {url: {__arrayElemAt: [
                {__split: [
                  '$$this.url',
                  '.png',
                ]},
                0,
              ]}},
            ],
          },
        },
      },
    },
  },
]))).to_a
