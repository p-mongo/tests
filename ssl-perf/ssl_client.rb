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

  all = []
  t = Benchmark.realtime do
    do_test(host, port) do |chunk|
      all << chunk
    end
    all.join('')
  end
  puts "Array append and join: %.5f" % t
end

do_all_tests(host, port)

puts "Loading"
load(400)

do_all_tests(host, port)

# Results:
#
# Read only: 0.14694
# Explicit buf read only: 0.12585
# Explicit large buf read only: 0.13010
# String append: 1.30883
# Array append: 0.15662
# Array append and join: 0.15834
# Loading
# Read only: 0.28593
# Explicit buf read only: 0.13307
# Explicit large buf read only: 0.13348
# String append: 2.20808
# Array append: 0.20270
# Array append and join: 0.34690
