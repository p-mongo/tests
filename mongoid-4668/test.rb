#!/usr/bin/env ruby



require 'bundler/inline'



gemfile do

  source 'https://rubygems.org'

  gem 'mongoid', '7.1.7'

end



require 'mongoid'


Mongo::Logger.logger.level=0

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14920'], database: 'test' } }



puts Mongoid::VERSION

puts Mongo::VERSION


class Foo; include Mongoid::Document; field :x, type: Regexp; end


a=Foo.new(x:'bar')
a.save!
a=Foo.find(a.id)
pp a.x
