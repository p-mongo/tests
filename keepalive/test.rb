require 'mongo'

module Mongo
  class Socket
    alias :set_socket_options_orig :set_socket_options

    def set_socket_options(sock)
      set_socket_options_orig(sock)
      sock.setsockopt(Socket::IPPROTO_TCP, :TCP_KEEPINTVL, 5)
    end
  end
end

c = Mongo::Client.new(['127.0.0.1:27027'])
c.cluster.next_primary.with_connection do |conn|
  conn.connect!
  p conn.send(:socket).send(:socket).getsockopt(Socket::IPPROTO_TCP, :TCP_KEEPINTVL).int
end

