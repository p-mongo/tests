class Post
  include Mongoid::Document

  field :user_id, type: String
  field :title, type: String
  field :metadata, type: Hash

  field :bar, type: String
  #validates_uniqueness_of :bar
  #validates_format_of :bar, with: /\A.\z/

  belongs_to :user, optional: true

  has_many :comments
  embeds_one :vote

  has_many :things
end
