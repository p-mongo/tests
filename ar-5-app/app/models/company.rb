class Company < ApplicationRecord
  has_many :emails, foreign_key: 'c_fk', primary_key: 'c'
end
