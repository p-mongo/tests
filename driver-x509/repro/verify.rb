require 'openssl'

key = OpenSSL::PKey::RSA.new(File.read('client.pem'))
cert = OpenSSL::X509::Certificate.new(File.read('client.pem'))

p key
p cert
p cert.verify(key)

=begin
speed% openssl verify -CAfile ca.pem client.pem
C = US, ST = TestClientCertificateState, L = TestClientCertificateLocality, O = EducationClientCertificate, OU = TestClientCertificateOrgUnit, CN = Chris
error 7 at 0 depth lookup: certificate signature failure
error client.pem: verification failed
140531485324480:error:0407008A:rsa routines:RSA_padding_check_PKCS1_type_1:invalid padding:../crypto/rsa/rsa_pk1.c:66:
140531485324480:error:04067072:rsa routines:rsa_ossl_public_decrypt:padding check failed:../crypto/rsa/rsa_ossl.c:588:
140531485324480:error:0D0C5006:asn1 encoding routines:ASN1_item_verify:EVP lib:../crypto/asn1/a_verify.c:170:
=end
