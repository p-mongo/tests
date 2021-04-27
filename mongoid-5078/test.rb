#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mongoid', '7.2.2'
  gem 'byebug'
end

require 'byebug'
require 'mongoid'

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14920'], database: 'test' } }

puts Mongoid::VERSION
puts Mongo::VERSION

module MyModule

	module_function def create_background_job(atomic_selector)

		# This line throws a DocumentNotFound error when called from Profile's

		# after_save callback, because atomic_selector will have the outdated

		# sharded field.

		p atomic_selector
                p Profile.where(atomic_selector).first

	end

end



# Copied Profile class from profile.rb + an added after_save callback.

class Profile

  include Mongoid::Document

  field :name, type: String

  shard_key :name



  after_save do |document|

  	# This line will fail when the 'name' field (shard_key) has been updated. The

  	# failure will be because at this point in time, document.atomic_selector

  	# will contain the now-outdated value for the 'name' field.

  	byebug
        MyModule.create_background_job(document.atomic_selector)

  end

end



# Profile shard_key :name

profile = Profile.create(name: "Alice")



profile.name = "Bob"



# This line won't fail, but its triggered after_save callback, which in-turn

# will trigger MyModule.create_background_job(document.atomic_selector),

# which will then try to query the document using its outdated atomic_selector,

# will fail.

profile.save!

