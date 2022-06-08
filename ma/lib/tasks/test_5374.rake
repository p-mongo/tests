task 'test:5374:1' => :environment do

=begin
Mongoid::Errors::Validations: 
message:
  Validation of Post failed.
summary:
  The following errors were found: Users is too short (minimum is 1 character)
resolution:
  Try persisting the document with valid data or remove the validations.
=end

class User
  include Mongoid::Document
  has_and_belongs_to_many :posts
end

class Post
  include Mongoid::Document
  has_and_belongs_to_many :users
  validates :users, length: { minimum: 1, maximum: 2 }
end

user=User.create!
post = user.posts.create!

end

task 'test:5374:2' => :environment do

=begin
No error
=end

class User
  include Mongoid::Document
  has_and_belongs_to_many :posts
end

class Post
  include Mongoid::Document
  has_and_belongs_to_many :users
  # Use user_ids instead of users
  validates :user_ids, length: { minimum: 1, maximum: 2 }
end

user=User.create!
post = user.posts.create!

end

task 'test:5374:3' => :environment do

=begin
No error
=end

class User
  include Mongoid::Document
  has_and_belongs_to_many :posts
end

class Post
  include Mongoid::Document
  has_and_belongs_to_many :users
  # Use user_ids instead of users
  validates :users, length: { minimum: 1, maximum: 2 }
  
  before_validation do
    # access the association and force it to be populated
    users.to_a
    
    # insufficient:
    #users.length
  end
end

user=User.create!
post = user.posts.create!

end
