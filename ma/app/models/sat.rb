class Sat
  include Mongoid::Document

  field :d, type: Date
  field :t, type: Time
  field :dt, type: DateTime
end
