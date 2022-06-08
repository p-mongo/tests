task 'test:4925' => :environment do

class User
    include Mongoid::Document
  has_and_belongs_to_many :posts
end

class Post
    include Mongoid::Document
  has_and_belongs_to_many :users
  validates :users, length: { minimum: 1, maximum: 2 }

  before_validation do
    p 'before validation'
    p user_ids
    p users
    p '--'
end
end

user=User.create!
another_user=User.create!
aanother_user=User.create!


# Fails with
#   The following errors were found: Users is too short (minimum is 1 character)
# when validating users but not when validating user_ids
 post = user.posts.create!
 p post.users

 post.users << another_user

p post.users
p post.users.length

 post.users << aanother_user

p post.users

#byebug

p post.users.length



end
