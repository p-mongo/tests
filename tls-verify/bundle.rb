require 'openssl'

# OK: openssl  verify  -CAfile ca.crt client.pem
# Fail: openssl  verify  -CAfile ca.crt python-client.pem
# OK: openssl  verify  -CAfile ca-rogue.crt python-client.pem
# OK: openssl  verify  -CAfile ca.crt -untrusted client-int.crt client-second-level.pem
# Fail: openssl  verify  -CAfile ca.crt  client-second-level-bundle.pem

include OpenSSL::X509

cert = Certificate.new(File.read('ca.crt'))
p cert
pk = OpenSSL::PKey.read(File.read('client.pem'))
p pk
