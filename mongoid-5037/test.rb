#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mongoid', '7.2.1'
end

require 'mongoid'

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14400'], database: 'test' } }

puts Mongoid::VERSION

puts Mongo::VERSION

class Parent

   include Mongoid::Document

   embeds_many :blocks

end



class Block

   include Mongoid::Document

   field :name, type: String

   embedded_in :parent
   embeds_many :children

end



class Child

   include Mongoid::Document

   embedded_in :block



   field :size, type: Integer

   field :order, type: Integer

   field :t

end



Mongo::Logger.logger=Logger.new(STDERR)

Mongo::Logger.logger.level=Logger::DEBUG





parent = Parent.new

parent.blocks << Block.new(name: 'test', children: [size: 1, order: 1])
parent.blocks << Block.new(name: 'test', children: [size: 1, order: 3])

parent.save!


pp parent.attributes

parent.blocks[0].children[0].assign_attributes(order: 2)

pp parent.attributes

p 'destroying'

#parent.blocks.where(:name => 'test').map(&:destroy)
parent.blocks.where(:name => 'test').destroy_all
#parent.blocks.destroy_all(:name => 'test')


parent.reload

pp parent.attributes
