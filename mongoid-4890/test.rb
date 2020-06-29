#/usr/bin/env ruby

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


class User
  include Mongoid::Document

  field :name, type: String
  has_many :stuff, dependent: :restrict_with_error
end

class Stuff
  include Mongoid::Document

  field :foo, type: String
  belongs_to :user
end

# Ensure the collection for each mongoid model already exists before a
# transaction is entered
Mongoid.models.each do |model|
  model.collection.create
rescue Mongo::Error::OperationFailure
  nil
end

user = User.create!(name: 'my user')
Stuff.create!(foo: 'bar', user: user)

user.reload

user.with_session do |session|
  session.start_transaction
  user.destroy
  session.commit_transaction
end
