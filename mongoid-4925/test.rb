require 'mongoid'
require 'byebug'

Mongo::Logger.logger.level = 1

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14420'],
    database: 'my_db',
  }

  config.log_level = :fatal
end


class User
  include Mongoid::Document

  has_and_belongs_to_many :posts

end



class Post
  include Mongoid::Document

  has_and_belongs_to_many :users

  validates :user_ids, length: { minimum: 1, maximum: 2 }

end

user = User.create!
post = user.posts.create!
p post
byebug
1
