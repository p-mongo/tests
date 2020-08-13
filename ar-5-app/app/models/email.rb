class Email < ApplicationRecord
  belongs_to :company, foreign_key: 'c_fk', primary_key: 'c'
end
