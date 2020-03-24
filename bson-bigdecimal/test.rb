require 'bson'

class BigDecimal
  def bson_type
    BSON::Decimal128::BSON_TYPE
  end

  def to_bson(*args)
    BSON::Decimal128.new(self).to_bson(*args)
  end
end

doc = {test: BigDecimal('1.234')}

p Hash.from_bson(doc.to_bson)
