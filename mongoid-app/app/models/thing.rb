class Thing
  include Mongoid::Document

  belongs_to :post

  field :message, type: String
  field :num, type: Integer
  field :metadata, type: Hash
end
