require 'byebug'
require "mongoid"

Mongoid.load!('mongoid.yml', 'development')

class Model
  include Mongoid::Document

  field :stuff, type: Hash
end

Model.delete_all

=begin
m = Model.create!(stuff: {a: :b})
p m
m = Model.find(m.id)
p m
=end

puts '-------------'

d = Model.collection.insert_one(stuff: {a: :b})
p d.documents.first
d = Model.find(d['id'])
p d
d
