require 'sinatra'
require 'mongoid'

Mongo::Logger.logger.level = Logger::WARN

Mongoid.configure do |config|
  config.clients.default = {
    uri: ENV['MONGODB_URI'],
    database: 'my_db',
    max_pool_size: 1,
    server_selection_timeout: 3,
    socket_timeout: 5,
  }

  config.log_level = :warn
end

Thread.new do
  loop do
    puts "pid=#{$$}: #{Mongoid::Clients.default.cluster.summary}"
    sleep 1
  end
end

class Model
  include Mongoid::Document

  field :foo, type: String
end

100.times do |i|
  Model.create!(foo: "test #{i}")
end

get '/' do
  begin
    Model.count
    'ok'
  rescue => e
    "error: #{e.class}: #{e}"
  end
ensure
  p Mongoid::Clients.default
end
