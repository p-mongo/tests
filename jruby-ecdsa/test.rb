require 'openssl'
require 'socket'

tcp_socket = TCPSocket.new 'localhost', 9999
context = OpenSSL::SSL::SSLContext.new
context.cert = OpenSSL::X509::Certificate.new(File.read('server.pem'))
context.key = OpenSSL::PKey::EC.new(File.read('server.pem'))
ssl_socket = OpenSSL::SSL::SSLSocket.new tcp_socket, context
p ssl_socket.connect
p ssl_socket.write('x')
p ssl_socket.read(1)
