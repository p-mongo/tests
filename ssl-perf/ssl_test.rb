require 'socket'
require 'openssl'

myXML = "GET / HTTP/1.0\n\n"
host = 'github.com'
port = 443

socket = TCPSocket.open(host,port)
ssl_context = OpenSSL::SSL::SSLContext.new()
ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
ssl_socket.sync_close = true
ssl_socket.connect

ssl_socket.puts(myXML)
while line = ssl_socket.gets
  puts line
end
ssl_socket.close
