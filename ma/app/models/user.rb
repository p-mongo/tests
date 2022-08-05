class User
  include Mongoid::Document

  belongs_to :country, index: true
end
