task :test_5083 => :environment do

Mongo::Logger.logger.level=0

class Person
  include Mongoid::Document
  has_many :posts#, autosave: true
  accepts_nested_attributes_for :posts
end

class Post
  include Mongoid::Document
  belongs_to :person
end

person = Person.new
post = Post.new

            post.with(collection: 'other-posts') do |post|
              person.with(collection: 'other-people') do |person|
                post.person = person
                person.save!
                post.save!
              end
            end

end

task :test_5083_1 => :environment do

Mongo::Logger.logger.level=0

class Person
  include Mongoid::Document
  has_many :posts#, autosave: true
  accepts_nested_attributes_for :posts
end

class Post
  include Mongoid::Document
  belongs_to :person
end

person = Person.new
post = Post.new

post.person = person
p post.persisted?
person.save!
p post.persisted?

end

