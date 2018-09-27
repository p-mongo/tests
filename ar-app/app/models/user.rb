class User < ApplicationRecord
  has_many :posts
  validates_presence_of :posts
  accepts_nested_attributes_for :posts, allow_destroy: true
end
