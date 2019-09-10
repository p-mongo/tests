class Car
  include Mongoid::Document

  embeds_many :engines

  field :make, type: String
end
