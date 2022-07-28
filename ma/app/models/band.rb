class Band
  include Mongoid::Document

  field :name, type: String
  field :description, type: String
  field :likes, type: Integer
  field :year, type: Array

  field :t, type: Time
  field :o
end
