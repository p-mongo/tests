#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mongoid', '7.2.2'
end

require 'mongoid'

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14920'], database: 'test' } }

puts Mongoid::VERSION

puts Mongo::VERSION


class Article

  include Mongoid::Document

  has_many :comments

end



class Comment

  include Mongoid::Document

  belongs_to :article

end

    article = Article.create!

    comment = Comment.create!(article: article)



    pp article.comments.length # => 1

    article.comments.destroy_all

    pp article.comments.length # => Continues to give 1 and should give 0

    article.comments.clear

    pp article.comments.length # => 0


