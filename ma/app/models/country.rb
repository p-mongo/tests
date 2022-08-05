class Country
  include Mongoid::Document

  field :size, type: BigDecimal
  field :extent, type: Integer
  field :breadth, type: BSON::Decimal128

  has_many :users
end
