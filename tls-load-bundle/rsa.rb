require 'openssl'

pk = OpenSSL::PKey::RSA.new(File.read('client.pem'))
p pk
