class Cat
  include Mongoid::Document

  field :age, type: Integer

  after_save do
    p 'in cat after save'
    p self
    p attribute_was(:age)
  end

  around_save :as
  def as
    p 'cat around save enter'
    yield
    p 'cat around save exit'
  end

  embedded_in :band
end
