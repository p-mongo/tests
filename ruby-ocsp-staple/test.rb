require 'openssl'

host = 'cluster0-shard-00-00-jxeqq.mongodb.net'

s = TCPSocket.open(host, 27017)
context = OpenSSL::SSL::SSLContext.new
ss = OpenSSL::SSL::SSLSocket.new(s, context)
ss.hostname = host
ss.connect

p ss.peer_cert
