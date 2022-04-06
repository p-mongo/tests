class City
  include Mongoid::Document

  field :name, type: String
  field :founded, type: Integer

  embedded_in :band
end
