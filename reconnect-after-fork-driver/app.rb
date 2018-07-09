require 'mongo'
require 'sinatra'

$client = Mongo::Client.new(ENV['MONGODB_URI'] || 'mongodb://localhost:27017')
10.times do
  $client['test'].insert_one(a: 'x'*15000000)
end

class App < Sinatra::Base
  get '/' do
    doc = $client['test'].find(a: {'$ne' => nil}).first
    doc.to_json
  end

  post '/' do
    $client['test'].insert_one(params)
    'ok'
  end
end
