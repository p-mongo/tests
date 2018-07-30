class Post
  include Mongoid::Document

  field :user_id, type: String
  field :title, type: String
  field :bar, type: String

  #validates_uniqueness_of :bar

  belongs_to :user, optional: true
end
