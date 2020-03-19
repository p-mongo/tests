require 'socket'
require 'timeout'
#require 'ruby-debug'

puts 'init'
socket = Socket.new(2, 1, 0)

puts 'connect'
Timeout.timeout(1) do
  # example.com
  socket.connect(::Socket.pack_sockaddr_in(27017, '93.184.216.34'))
end
