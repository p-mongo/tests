require 'openssl'

store = OpenSSL::X509::Store.new
store.add_file('ca.crt')

client_cert = OpenSSL::X509::Certificate.new(File.read('client.crt'))

p store.verify(client_cert)

int_cert = OpenSSL::X509::Certificate.new(File.read('client-int.crt'))

p store.verify(int_cert)

client_cert = OpenSSL::X509::Certificate.new(File.read('client-second-level.crt'))

p store.verify(client_cert, [int_cert])
p store.error
p store.error_string
