require 'byebug'
require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:27100'],
    database: 'my_db',
  }

  config.log_level = :warn
end

class Post
  include Mongoid::Document

  field :title, type: String
end

#10000.times { Post.create!(title: 'blah') }

10.times { Post.where(title: 'blah').no_timeout.each { break } }

GC.start

sleep 1
puts 'done'
