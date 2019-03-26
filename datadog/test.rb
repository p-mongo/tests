require 'mongo'
require 'ddtrace'

Datadog.configure do |c|
  c.use :mongo, {}
end

# Create a MongoDB client and use it as usual
client = Mongo::Client.new([ '127.0.0.1:27017' ], :database => 'artists')
collection = client[:people]
collection.insert_one({ name: 'Steve' })
