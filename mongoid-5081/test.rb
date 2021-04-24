#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mongoid', '7.0.12'
end

require 'mongoid'

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14920'], database: 'test' } }

puts Mongoid::VERSION

puts Mongo::VERSION

class Article

  include Mongoid::Document

  embeds_many :comments, order: :body.asc

end



class Comment

  include Mongoid::Document

  embedded_in :article



  field :body, type: String

end



article = Article.new

pp article.comments.criteria

article.comments.build(body: 'test')

pp article.comments.count # => gives 0 instead of 1
#pp article.comments.length

pp article.comments.where(body: 'test').count # => gives 0 instead of 1

pp article.comments.context.documents # gives an empty array


