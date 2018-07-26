class Post
  include Mongoid::Document

  field :user_id, type: String

  belongs_to :user, optional: true
end
