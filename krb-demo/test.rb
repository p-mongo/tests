require 'mongo'
require 'mongo_kerberos'

p Socket.gethostname

client = Mongo::Client.new("mongodb://rubytest%2fyay%40LOCALKRB@#{Socket.gethostname}/kerberos?authmechanism=gssapi",
max_pool_size: 1)
p '---------------------------------'
p client['test'].find.first
p '================================='
