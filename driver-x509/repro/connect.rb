require 'mongo'

client = Mongo::Client.new([ 'localmongo1:27017' ],
                           auth_mech: :mongodb_x509,
                           ssl: true,
                           ssl_cert: './client.pem',
                           ssl_ca_cert: './ca.pem')

db = client.database[:test]
collection = client[:stuff]

doc = { name: 'Ruby', hobbies: [ 'hiking', 'tennis', 'fishing' ] }

result = collection.insert_one(doc)
puts result.n