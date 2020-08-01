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

# https://www.phusionpassenger.com/library/indepth/ruby/spawn_methods/#the-need-to-revive-threads
if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|
    if forked
      p 'starting worker'
      Mongoid::Clients.clients.each do |name, client|
        client.close
        client.reconnect
      end
    end
  end
end

# This forces the client to be created before fork, when --preload is used.
p Foo.count

run App
