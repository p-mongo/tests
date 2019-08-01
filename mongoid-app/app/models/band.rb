class Band
  include Mongoid::Document

  field :name, type: String

  embeds_many :cities
end