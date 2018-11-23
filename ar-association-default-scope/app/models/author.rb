class Author < ApplicationRecord
  has_many :comments
  default_scope -> { where(deleted_at: nil) }
end
