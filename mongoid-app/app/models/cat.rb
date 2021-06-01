class Cat
  include Mongoid::Document

  field :age, type: Integer

  after_save do
    p self
    p attribute_was(:age)
  end
end
