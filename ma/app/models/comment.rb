class Comment
  include Mongoid::Document

  belongs_to :post

  field :message, type: String
end
