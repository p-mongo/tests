class NestedField
  include Mongoid::Document

  field :stuff, type: Hash
end
