require 'openssl'

include OpenSSL::X509

puts 'Rogue CA, good cert'

store = Store.new
store.add_file('ca-rogue.crt')

client_cert = Certificate.new(File.read('client.pem'))

result = store.verify(client_cert)
puts "Result: #{result}"

# --

puts 'Rogue CA, rogue cert'

store = Store.new
store.add_file('ca-rogue.crt')

client_cert = Certificate.new(File.read('python-client.pem'))

result = store.verify(client_cert)
puts "Result: #{result}"

# --

puts 'Good CA, good cert - bundle'

store = Store.new
store.add_file('ca.crt')

client_cert = Certificate.new(File.read('client-second-level-bundle.pem'))

result = store.verify(client_cert)
puts "Result: #{result}"

store = Store.new
store.add_file('ca.crt')

client_cert = Certificate.new(File.read('client.crt'))

p store.verify(client_cert)

int_cert = Certificate.new(File.read('client-int.crt'))

p store.verify(int_cert)

client_cert = Certificate.new(File.read('client-second-level.crt'))

p store.verify(client_cert, [int_cert])
p store.error
p store.error_string
