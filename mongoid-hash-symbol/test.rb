require 'byebug'
require "mongoid"

Mongoid.load!('mongoid.yml', 'development')

class Model
  include Mongoid::Document

  field :stuff, type: Hash
end

Model.delete_all

m = Model.create!(stuff: {a: :b})
p m
m = Model.find(m.id)
p m

puts '-------------'

d = Model.collection.insert_one(stuff: {a: :b}, _id: 123)
d = Model.find(123)
p d
