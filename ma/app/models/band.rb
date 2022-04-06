class Band
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :likes, type: Integer
  field :year, type: Array
end
