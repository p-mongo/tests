class Post < ApplicationRecord
  belongs_to :user, optional: true
  validates_presence_of :title
end
