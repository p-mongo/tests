#!/usr/bin/env ruby

# Run the server:
# openssl s_server -port 29999  -CAfile ca.crt -verify 1 -cert server.pem

require 'openssl'

context = OpenSSL::SSL::SSLContext.new
#context.cert = OpenSSL::X509::Certificate.new(File.read('client.pem'))
#context.cert = OpenSSL::X509::Certificate.new(File.read('client-second-level.pem'))
context.cert = OpenSSL::X509::Certificate.new(File.read('client-second-level-bundle.pem'))

tcp_socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
tcp_socket.connect(Socket.pack_sockaddr_in(29999, '127.0.0.1'))
ssl_socket = OpenSSL::SSL::SSLSocket.new(tcp_socket, context)
ssl_socket.hostname = 'localhost'
ssl_socket.connect

p OpenSSL::SSL.verify_certificate_identity(ssl_socket.peer_cert, 'localhost')

p ssl_socket.write('test')
