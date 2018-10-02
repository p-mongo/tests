class Post
  include Mongoid::Document

  belongs_to :user

  field :title, type: String
  validates_presence_of :title
end
