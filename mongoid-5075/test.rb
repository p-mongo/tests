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

  has_many :comments

end



class Comment

  include Mongoid::Document

  belongs_to :article, required: false

end



comment = Comment.create!
p comment



Article.destroy_all

article = Article.create!(

  comment_ids: [comment.id],

  id: '1234',

)

p article
p comment
p article.comments.first



pp article.comments.count #=> 1

pp article.comments.criteria.selector['article_id'] # => Gives a random id

pp article.comments.context.view.count # => 1



article.reload



pp article.comments.count # => 0

pp article.comments.criteria.selector['article_id'] #=> '123'

pp article.comments.context.view.count # => 0
