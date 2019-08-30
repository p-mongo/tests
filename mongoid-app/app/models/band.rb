class Band
  include Mongoid::Document

  field :name, type: String
  field :description, type: String

  index description: 'text'
end
