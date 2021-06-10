#!/usr/bin/env ruby



require 'bundler/inline'



gemfile do

  source 'https://rubygems.org'

  gem 'mongoid', '7.0.12'

  gem 'pry-byebug'

end



require 'mongoid'



Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14740'], database: 'test' } }



puts Mongoid::VERSION

puts Mongo::VERSION



Mongoid.logger.level = 4

Mongo::Logger.logger.level = 0



class Article

  include Mongoid::Document

  has_many :comments, autosave: true

  before_save :log_save



  def log_save

    pp "Article#save #{object_id}"

  end

end



class Comment

  include Mongoid::Document

  belongs_to :article, autosave: true

  field :body, type: String

  before_save :log_save



  def log_save

    pp "Comment#save #{object_id}"

  end

end



article = Article.new

article.comments << Comment.new



article.save!



puts "################################################################################"



article.comments << Comment.new

article.comments << Comment.new



article.save!



puts "################################################################################"

article.comments.last.save!

