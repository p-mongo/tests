require 'socket'
require 'timeout'
require 'thread'

puts 'init'
socket = Socket.new(2, 1, 0)

thread = Thread.new do
  puts 'connect'
  # example.com
  socket.connect(::Socket.pack_sockaddr_in(27017, '93.184.216.34'))
end

sleep 1
thread.kill
thread.join
