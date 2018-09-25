class Hone
  include Mongoid::Document

  has_and_belongs_to_many :htwos
end
