#!/usr/bin/env ruby




require 'mongoid'


Mongo::Logger.logger.level=0

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14400'], database: 'test' } }

class Manufactory
  include Mongoid::Document

  embeds_many :products, order: :id.desc # here
end

class Product
  include Mongoid::Document

  embedded_in :manufactory

  field :name, type: String
end


manufactory = Manufactory.create!

p Product.create!(manufactory:manufactory,name:'car', id: 1)
p Product.create!(manufactory:manufactory,name:'car', id: 2)

p manufactory.products

manufactory.reload

p 'after reload'
p Product.create!(manufactory:manufactory,name:'car', id: 3)
p manufactory.products

manufactory.products.destroy_all

p 'after destroy'
p manufactory.products

manufactory.reload

p manufactory.products
