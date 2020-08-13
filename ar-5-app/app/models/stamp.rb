class Stamp < ApplicationRecord
  default_scope -> { order('t') }
end
