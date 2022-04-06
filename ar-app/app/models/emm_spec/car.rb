class EmmSpec::Car < ApplicationRecord
  has_many :doors
  has_many :bumpers
end
