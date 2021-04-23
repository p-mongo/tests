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

  has_many :comments, autosave: true

end



class Comment

  include Mongoid::Document

  belongs_to :article, required: false

end

Article.delete_all
Comment.delete_all


comment = Comment.create!
p comment


test = 1

case test
when 1
  article = Article.new(

    comment_ids: [comment.id],

    id: '1234',

  )
when 2
  article = Article.new(

    comments: [comment],

    id: '1234',

  )
end

p article
p comment
p article.comments.first
p comment

byebug
1
