require 'bson'

class Test
  def data
    @data ||= BSON::Document.new
  end

  def meta
    data["_meta"] ||= BSON::Document.new
  end
end

doc = BSON::Document.new
(doc['_meta'] ||= BSON::Document.new)['foo'] = 'bar'
p doc
