require 'mongo'

c = Mongo::Client.new(['localhost:14400'])
cc = c['foo']

cc.delete_many
cc.insert_many([
{
 id: '1234567',
 listOfSettings: [{
  name: 'setting1',
  listOfObjects: [{name: 'object1',id:'111'}, {name: 'object2', id: '112'}]
 }, {
  name: 'setting2',
  listOfObjects: [{name: 'object2',id:'113'}, {name: 'object3', id: '114'}]
 }]
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
{__project: {listOfSettings: {__map: {
  input: '$listOfSettings',as:'x',in:{__mergeObjects:['$$x',{listOfObjects:{__map: {
    input: '$$x.listOfObjects', as: 'y', in: '$$y.id',
  }}},
  ]}
}}}},
]))).to_a
