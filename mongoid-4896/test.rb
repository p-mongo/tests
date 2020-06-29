require 'mongoid'
require 'byebug'

mongo_settings = {
  clients: {
    default: {
      database: 'mongoid_delete_in_transaction_test',
      hosts: %w[127.0.0.1:14420],
    }
  }
}
Mongoid::Config.load_configuration(mongo_settings)


class BlogUser
  include Mongoid::Document
  field :name
  embeds_many :posts
  accepts_nested_attributes_for :posts
  before_save :track_changes

  def track_changes
    puts self.changes.inspect
  end

end

class Post
  include Mongoid::Document
  field :remarks
  embedded_in :blog_user
end

u = BlogUser.new(name: "test")
u.posts << Post.new(remarks: "test post")
u.save!

u = BlogUser.new(name: "test2")
u.posts_attributes = {"0"=>{remarks: "post 0"}, "1"=>{remarks: "post 1"}}
u.save!

=begin result:


{"_id"=>[nil, BSON::ObjectId('5efa5d382c97a6316f721f67')], "name"=>[nil, "test"]}

{"_id"=>[nil, BSON::ObjectId('5efa5d382c97a6316f721f6b')], "name"=>[nil, "test2"]}


In both cases the changes only include those in the top-level document.

=end
