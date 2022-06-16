class Cat
  include Mongoid::Document

  field :age, type: Integer
  field :kitten_ages, type: Array

  embeds_many :kittens
  embedded_in :house
end
