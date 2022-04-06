class House
  include Mongoid::Document

  embeds_many :cats
end
