require 'byebug'
require 'openssl'

OpenSSL.debug = true

#host = 'cluster0-shard-00-00-jxeqq.mongodb.net:27017'
host = 'login.live.com:443'

s = TCPSocket.open(*host.split(':'))
context = OpenSSL::SSL::SSLContext.new
context.status_cb = lambda do |socket, resp|
  #byebug
  true
end
ss = OpenSSL::SSL::SSLSocket.new(s, context)
ss.hostname = host.split(':').first
ss.status_type = 1
puts 'conn'
ss.connect

p ss.peer_cert
