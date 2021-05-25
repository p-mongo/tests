require "bundler/inline"



gemfile(true) do

  source "https://rubygems.org"

  gem "mongoid", "~> 7.3.0"

end



require "mongoid"

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14920'], database: 'test' } }

puts Mongoid::VERSION

puts Mongo::VERSION




class MyModel;include Mongoid::Document;field :attr1, type: Time;end



MyModel.any_of({ :attr1.exists => true }, { attr1: nil })
