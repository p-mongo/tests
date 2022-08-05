class Band < ApplicationRecord
  before_update do
    puts 'before update'
  end

  after_update do
    puts 'after update'
  end

  default_scope -> { where(x: 1) }
end
