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



class Article
  include Mongoid::Document
  has_many :comments
end

class Comment
  include Mongoid::Document
  belongs_to :article, required: false
end

Article.delete_all
Comment.delete_all

article = Article.new(
    comments: [Comment.new],
    id: 1,
)
p article.comments

puts

comment = Comment.create!

article = Article.new(
    comment_ids: [comment.id],
    id: 1,
)
p article.comments
p article

puts

article = Article.new(
    id: 1,
    comment_ids: [comment.id],
)
p article.comments
