require 'mongoid'
require 'byebug'

Mongo::Logger.logger.level = 1

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14420'],
    database: 'my_db',
  }

  config.log_level = :fatal
end

module Mongoid
  #class_attribute :discriminator_key, default: '_type'

  attr_accessor :discriminator_key
  self.discriminator_key = '_type'

  module Attributes
    included do
      class_attribute :discriminator_key
      class << self
        delegate :discriminator_key, to: ::Mongoid
      end
      #self.discriminator_key = '_type'
    end
  end
end

class Parent
  include Mongoid::Document

  self.discriminator_key = 'foo'
end

class Child < Parent
end

class GrandChild < Child
end

class Other
  include Mongoid::Document
end

Parent.delete_all

p Parent.create!
p Child.create!

p Parent.all.to_a

#p Mongoid.discriminator_key
p Parent.discriminator_key
p Child.discriminator_key

puts
Child.discriminator_key='bar'
p Parent.discriminator_key
p Child.discriminator_key
p GrandChild.discriminator_key
puts

p Other.discriminator_key

puts

p GrandChild.create!
