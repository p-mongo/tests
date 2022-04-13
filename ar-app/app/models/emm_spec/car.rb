class EmmSpec::Car < ApplicationRecord
  has_many :doors, class_name: "Door"
  has_many :bumpers, class_name: 'Bumper'
end
