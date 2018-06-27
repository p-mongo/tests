require 'benchmark'
require 'socket'
require 'openssl'
require_relative 'load'

host = 'localhost'
port = 5000

def do_test(host, port, buf: nil)
  socket = TCPSocket.open(host,port)
  ssl_context = OpenSSL::SSL::SSLContext.new()
  ssl_socket = OpenSSL::SSL::SSLSocket.new(socket, ssl_context)
  ssl_socket.sync_close = true
  ssl_socket.connect

  while true
    begin
      if buf
        chunk = ssl_socket.read_nonblock(1_000_000, buf)
      else
        chunk = ssl_socket.read_nonblock(1_000_000)
      end
      yield chunk
    rescue OpenSSL::SSL::SSLErrorWaitReadable
      sleep 0.1
      retry
    rescue EOFError
      break
    end
  end
  ssl_socket.close
end

def do_all_tests(host, port)
  t = Benchmark.realtime do
    do_test(host, port) do |chunk|
    end
  end
  puts "Read only: %.5f" % t

  t = Benchmark.realtime do
    do_test(host, port, buf: '') do |chunk|
    end
  end
  puts "Explicit buf read only: %.5f" % t

  buf = 'x'*15_000_000
  t = Benchmark.realtime do
    do_test(host, port, buf: buf) do |chunk|
    end
  end
  puts "Explicit large buf read only: %.5f" % t

  all = ''
  t = Benchmark.realtime do
    do_test(host, port) do |chunk|
      all += chunk
    end
  end
  puts "String append: %.5f" % t

  all = []
  t = Benchmark.realtime do
    do_test(host, port) do |chunk|
      all << chunk
    end
  end
  puts "Array append: %.5f" % t
end

do_all_tests(host, port)

puts "Loading"
load(400)

do_all_tests(host, port)

# Results:
#
# Read only: 0.15228
# Explicit buf read only: 0.13387
# Explicit large buf read only: 0.13169
# String append: 1.20166
# Array append: 0.15354
# Loading
# Read only: 0.28902
# Explicit buf read only: 0.13180
# Explicit large buf read only: 0.13264
# String append: 2.23689
# Array append: 0.32241
