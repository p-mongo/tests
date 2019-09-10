class Engine
  include Mongoid::Document

  embedded_in :car

  field :size, type: Integer
end
