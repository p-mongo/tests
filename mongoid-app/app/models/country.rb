  class Country
    include Mongoid::Document

has_many :zombies
end
