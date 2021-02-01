require 'mongoid'
require 'byebug'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14420'],
    database: 'my_db',
    options: {
      read: {
        mode: :secondary_preferred,
      },
    },
  }

  config.log_level = :debug
end

#Mongoid.logger = Mongo::Logger.logger = Logger.new(STDERR, level: 0)

class Model
  include Mongoid::Document

  field :foo, type: Integer
end

Model.with_session do |s|
  s.with_transaction(read: {mode: :primary}) do
    p Model.first
  end
end
