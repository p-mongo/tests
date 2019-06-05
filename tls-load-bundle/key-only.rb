require 'openssl'

pk = OpenSSL::PKey.read(File.read('client.key'))
p pk
