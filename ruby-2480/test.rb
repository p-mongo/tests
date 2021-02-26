require 'mongo'
require 'byebug'

client = Mongo::Client.new(['localhost:14400'])

class A

   def initialize

      @a = [1, 2, 3]

   end

   def bson_type

      @a.bson_type

   end

   def to_bson(*args)

      byebug
      puts "to_bson"

      @a.to_bson(*args)

   end

end

client['foo'].insert_one({ary: A.new})

