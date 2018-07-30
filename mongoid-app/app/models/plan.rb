class Plan
  include Mongoid::Document

  embedded_in :flight

  field :route, type: String
  field :num, type: Integer
end
