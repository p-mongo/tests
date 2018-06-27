require 'socket'
require 'openssl'

host = 'localhost'
port = 5000

socket = TCPSocket.open(host,port)
ssl_context = OpenSSL::SSL::SSLContext.new()
ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
ssl_socket.sync_close = true
ssl_socket.connect

while data = ssl_socket.read(1_000_000)
  puts data.length
end
ssl_socket.close
