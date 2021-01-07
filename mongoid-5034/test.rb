#!/usr/bin/env ruby



require 'bundler/inline'



gemfile do

  source 'https://rubygems.org'

  gem 'mongoid', '7.2.0'

end



require 'mongoid'



Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14400'], database: 'test' } }

puts Mongoid::VERSION

puts Mongo::VERSION



# From https://github.com/mongodb/mongoid/blob/master/spec/mongoid/association/embedded/embeds_many_models.rb

class EmmCongress

  include Mongoid::Document

  include Mongoid::Timestamps



  embeds_many :legislators, class_name: 'EmmLegislator'



  field :name, type: String

end



class EmmLegislator

  include Mongoid::Document



  embedded_in :congress, class_name: 'EmmCongress'



  field :a, type: Integer, default: 0

  field :b, type: Integer, default: 0

end



# From https://github.com/mongodb/mongoid/blob/master/spec/mongoid/association/embedded/embeds_many_query_spec.rb



# setup

congress = EmmCongress.new(name: 'foo')

congress.legislators << EmmLegislator.new(a: 1, b: 2)

congress.save!



# let

congress = EmmCongress.where(name: 'foo').only(:id).first



p congress.legislators

# => what I expect: ActiveModel::MissingAttributeError

# => what is returned: []



# p congress.name

# in comparison, this is raising ActiveModel::MissingAttributeError as expeted

