require 'socket'
require 'openssl'

tcp_server = TCPServer.new 5000

context = OpenSSL::SSL::SSLContext.new
context.key = OpenSSL::PKey::RSA.new(File.open("priv.pem"))
context.cert = OpenSSL::X509::Certificate.new(File.open("cert.pem"))
ssl_server = OpenSSL::SSL::SSLServer.new tcp_server, context

data = 'abcde' * 3_000_000

loop do

  ssl_connection = ssl_server.accept

  begin
    ssl_connection.puts data
  rescue
    # ignore
  end

  begin
    ssl_connection.close
  rescue
    # ignore
  end

end

# Test with:
# openssl s_client -connect localhost:5000
