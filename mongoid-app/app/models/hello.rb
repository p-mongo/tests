class Hello
  include Mongoid::Document

  field :dt, type: DateTime
  field :time, type: Time
  field :date, type: Date
end
