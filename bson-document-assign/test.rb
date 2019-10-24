require 'bson'
require 'byebug'

class Test
  def data
    @data ||= BSON::Document.new
  end

  def meta
    data["_meta"] ||= BSON::Document.new and data['_meta']
  end
end

test = Test.new

byebug

p test.meta[:foo] = "bar"
#=> "bar"

p test.meta
#=> {}

p test.meta[:foo] = "bar"
#=> "bar"

p test.meta
#=> {"foo" => "bar"}
