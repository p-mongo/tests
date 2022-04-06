class Kitten
  include Mongoid::Document

  field :age, type: Integer

  embedded_in :cat
end
