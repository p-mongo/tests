require 'socket'

s = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM)
p s.setsockopt(Socket::IPPROTO_TCP, Socket::TCP_KEEPINTVL, 0)
