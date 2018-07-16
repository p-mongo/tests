require 'mongo'
require 'sinatra'

$client = Mongo::Client.new(
  ENV['MONGODB_URI'] || 'mongodb://localhost:27017',
  ssl_verify: false,
)
10.times do
  $client['test'].insert_one(a: 'x'*15000000)
end

class App < Sinatra::Base
  get '/' do
    count = $client['test'].find(a: {'$ne' => nil}).count
    puts "Found #{count}"
    'ok'
  end

  post '/' do
    $client['test'].insert_one(params)
    'ok'
  end
end
