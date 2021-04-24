#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mongoid', '7.0.12'
  gem 'byebug'
end

require 'byebug'
require 'mongoid'

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14920'], database: 'test' } }

puts Mongoid::VERSION
puts Mongo::VERSION


module Blog

  class Article

    include Mongoid::Document

    embeds_many :comments
    embeds_many :tops

  end



  class Comment

    include Mongoid::Document

    embedded_in :article

  end

end

class Top
    include Mongoid::Document

    embedded_in :article, class_name: 'Blog::Article'
end



byebug
1
