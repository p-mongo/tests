class Company
  include Mongoid::Document

  has_many :emails, order: {foo: 1}
end
