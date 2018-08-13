require 'byebug'
require 'mongoid'
require 'sinatra'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:27017'],
    database: 'my_db',
  }

  config.log_level = :debug
end

class Model
  include Mongoid::Document
end

byebug

begin
  Timeout.timeout(1) do
    Model.count
  end
rescue => e
  puts e
end

class App < Sinatra::Base
  get '/' do
    count = Model.count
    puts "Found #{count}"
    count.to_s
  end

  post '/' do
    Model.create!
    'ok'
  end
end
