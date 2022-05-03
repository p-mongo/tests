require 'mongo'
require 'byebug'

c = Mongo::Client.new(['localhost'])

class A
  def initialize(x)
    @x = x
  end

  def bson_type
    @x.bson_type
  end

  def to_bson(*args)
    p 'to bson'
    byebug
    @x.to_bson(*args)
  end
end

c['foo'].insert_one(a: A.new('b'))


# 1. max_bson_size check
# 2. serialize - check for invalid keys
# 3. max_bson_size check
# 4. serialize - check for document exceeding 16mb limit prior to compression
# (redundant if not compressing)
# 5. max_bson_size check
# 6. serialize - actual serialization
