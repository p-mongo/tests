# Run with:
# puma -w 2 --preload config.ru

require 'sinatra'
require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14420'],
    database: 'my_db',
    options: {
      server_selection_timeout: 1,
    },
  }
end

class Foo
  include Mongoid::Document
end

class App < Sinatra::Base
  get '/' do
    p Foo.collection.client.cluster.summary
    Foo.collection.client.cluster.servers.map(&:unknown!)
    Foo.count.to_s
  end
end

# This forces the client to be created before fork, when --preload is used.
p Foo.count

run App
