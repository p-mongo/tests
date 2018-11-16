class Email
  include Mongoid::Document

  belongs_to :company, primary_key: 'e', foreign_key: 'e_id'
end
