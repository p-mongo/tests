require 'sinatra'
require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    uri: ENV['MONGODB_URI'],
    database: 'my_db',
    max_pool_size: 1,
    server_selection_timeout: 3,
  }

  config.log_level = :warn
end

class Model
  include Mongoid::Document

  field :foo, type: String
end

100.times do |i|
  Model.create!(foo: "test #{i}")
end

get '/' do
  {count: Model.count}.to_json
end
