require 'openssl'

def check(desc, ca_path, cert_path)
  store = OpenSSL::X509::Store.new
  store.add_file(ca_path)

  client_cert = OpenSSL::X509::Certificate.new(File.read(cert_path))

  result = store.verify(client_cert)

  puts "#{desc}: #{result}"
end

check('Rogue CA, good cert', 'ca-rogue.crt', 'client.pem')
check('Rogue CA, rogue cert', 'ca-rogue.crt', 'python-client.pem')
check('Good CA, good cert', 'ca.crt', 'client.pem')
check('Good CA, good cert - bundle', 'ca.crt', 'client-second-level-bundle.pem')
check('Good CA, good cert - bundle', 'ca.crt', 'server-second-level-bundle.pem')
