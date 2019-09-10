require 'yaml'
require 'sinatra'
require 'mongoid'

Mongo::Logger.logger.level = Logger::WARN

if ENV['CONFIG_PATH']
  config = YAML.load(File.read(ENV['CONFIG_PATH'])).deep_symbolize_keys
end

unless config
  raise 'Missing config'
end

Mongoid.configure do |mc|
  mc.clients.default = {
    uri: config[:uri],
    database: 'my_db',
    max_pool_size: 1,
    server_selection_timeout: 3,
    socket_timeout: 5,
  }

  mc.log_level = :warn
end

Thread.new do
  loop do
    #puts "pid=#{$$}: #{Mongoid::Clients.default.cluster.summary}"
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
    {ok: true, summary: Mongoid::Clients.default.cluster.summary}.to_json
  rescue => e
    {error: "#{e.class}: #{e}",
      summary: Mongoid::Clients.default.cluster.summary}.to_json
  end
end
