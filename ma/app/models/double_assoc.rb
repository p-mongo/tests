class DoubleAssoc
  include Mongoid::Document

  has_many :deps, dependent: :destroy
end

class DoubleAssocOne < DoubleAssoc
  has_many :deps, dependent: :nullify, inverse_of: :double_assoc
end

class DoubleAssocTwo < DoubleAssocOne
  has_many :deps, dependent: :destroy, inverse_of: :double_assoc
end
