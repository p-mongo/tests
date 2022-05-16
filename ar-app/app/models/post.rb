class Post < ApplicationRecord
  belongs_to :user, optional: true

  after_save :after_save
  after_commit :after_commit
  after_rollback :after_rollback

  def after_save
    p "Saved #{self}"
  end

  def after_commit
    p "Committed #{self}"
  end

  def after_rollback
    p "Undo #{self}"
  end
end
