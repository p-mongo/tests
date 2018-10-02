class User
  include Mongoid::Document

  belongs_to :department
  has_many :posts
end
