#!/usr/bin/env ruby



require 'bundler/inline'



gemfile do

  source 'https://rubygems.org'

  gem 'mongoid', '~> 7.2.0'

  gem 'pry-byebug'

end



require 'mongoid'



Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14740'], database: 'test' } }



puts Mongoid::VERSION

puts Mongo::VERSION



Mongoid.logger.level = 4

Mongo::Logger.logger.level = 0


class CollegeListing

  include Mongoid::Document



  field :loc, type: Array

end



p CollegeListing.where(loc: { '$near' => [20, 20] }).count
