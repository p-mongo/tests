class User
  include Mongoid::Document

  field :name, type: String
  field :city, type: String

  validates_uniqueness_of :name

  has_many :posts
end
