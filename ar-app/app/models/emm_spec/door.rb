puts 'loading emmspec::door'
class EmmSpec::Door < ApplicationRecord
  DefinedConstant
  belongs_to :car
end
