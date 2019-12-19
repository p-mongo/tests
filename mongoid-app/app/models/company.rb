class Company
  include Mongoid::Document

  has_many :emails, primary_key: 'e', foreign_key: 'e_id'

  index name: 1
end
