require 'byebug'
require "mongoid"

Mongoid.load!('mongoid.yml', 'development')

class Model
  include Mongoid::Document

  field :stuff, type: Hash
end

m = Model.create!(stuff: {a: :b})
p m
m = Model.find(m.id)
p m
