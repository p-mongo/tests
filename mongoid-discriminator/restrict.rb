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

    module DiscriminatorKeyAssignment
      def discriminator_key=(value)
        if hereditary?
          raise "uh oh: #{self}"
        end
        super
      end
    end

    included do
      class_attribute :discriminator_key
      class << self
        delegate :discriminator_key, to: ::Mongoid
        prepend DiscriminatorKeyAssignment
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

  #self.discriminator_key = 'bar'
end

p Child.discriminator_key
