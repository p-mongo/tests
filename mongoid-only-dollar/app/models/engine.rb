class Engine
  include Mongoid::Document

  embedded_in :car

  field :displacement, type: Integer
end
