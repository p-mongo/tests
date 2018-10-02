class Department
  include Mongoid::Document

  has_many :users

  field :name, type: String
  validates_presence_of :name
end
