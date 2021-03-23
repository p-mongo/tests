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
   embedded_in :parent
   field :name
end

parent = Parent.create!(blocks: [Block.new(name: 'test',)])


pp parent.attributes

#parent.blocks.where(:name => 'test').map(&:destroy)
#parent.blocks.where(:name => 'test').destroy_all
parent.blocks.destroy_all(:name => 'test')

parent.reload

pp parent.attributes
