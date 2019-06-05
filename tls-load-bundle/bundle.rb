require 'openssl'

pk = OpenSSL::PKey.read(File.read('client.pem'))
p pk
