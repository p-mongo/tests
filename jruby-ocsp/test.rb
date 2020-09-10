require 'openssl'
require 'socket'

tcp_socket = TCPSocket.new 'login.live.com', 443
ssl_socket = OpenSSL::SSL::SSLSocket.new tcp_socket
ssl_socket.connect

cert = ssl_socket.peer_cert
p cert

p cert.extensions.map(&:oid)

ocsp_ext = cert.extensions.detect { |ext| ext.oid == 'authorityInfoAccess' }
p ocsp_ext
p ocsp_ext.value
