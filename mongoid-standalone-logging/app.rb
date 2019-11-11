require 'sinatra'
require 'mongoid'
require 'byebug'

p :Configuring
Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14420'],
    database: 'my_db',
  }

  config.log_level = :fatal
end

class Model
  include Mongoid::Document

  field :foo, type: Integer
  field :foo, type: String
end

get '/' do
  Model.first
  'hello world'
end
