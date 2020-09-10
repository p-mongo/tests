require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14420'],
    database: 'my_db'
  }
end

class Foo
  include Mongoid::Document

  field :one
end

Mongoid::QueryCache.enabled = true

loop do
  Foo.with_session do
    #Foo.create!
  end

  session = Foo.collection.client.start_session
  #Foo.collection.insert_one({a: 1}, session: session)
end
