require 'mongo'
require 'sinatra'

$client = Mongo::Client.new(ENV['MONGODB_URI'] || 'mongodb://localhost:27017')

get '/' do
  doc = $client['test'].find(a: {'$ne' => nil}).first
  doc.to_json
end

post '/' do
  $client['test'].insert_one(params)
  'ok'
end
