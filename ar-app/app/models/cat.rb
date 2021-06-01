class Cat < ApplicationRecord
  after_save do
    p self
    p attribute_was(:age)
  end
end
