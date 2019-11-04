class Thing
  include Mongoid::Document

  embedded_in :post

  field :message, type: String
  field :num, type: Integer
  field :metadata, type: Hash
end
