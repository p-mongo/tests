class User
  include Mongoid::Document

  belongs_to :country, index: true
  has_and_belongs_to_many :jobs, index: true
end
