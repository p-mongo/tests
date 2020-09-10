## MRI

    serene% ruby test.rb
    #<OpenSSL::X509::Certificate: subject=#<OpenSSL::X509::Name CN=login.live.com,O=Microsoft Corporation,L=Redmond,ST=Washington,C=US>, issuer=#<OpenSSL::X509::Name CN=DigiCert SHA2 Secure Server CA,O=DigiCert Inc,C=US>, serial=#<OpenSSL::BN:0x00005593c2286328>, not_before=2020-07-07 00:00:00 UTC, not_after=2021-07-07 12:00:00 UTC>
    ["authorityKeyIdentifier", "subjectKeyIdentifier", "subjectAltName", "keyUsage", "extendedKeyUsage", "crlDistributionPoints", "certificatePolicies", "authorityInfoAccess", "basicConstraints", "ct_precert_scts"]
    #<OpenSSL::X509::Extension:0x00005593c2285978>
    "OCSP - URI:http://ocsp.digicert.com\nCA Issuers - URI:http://cacerts.digicert.com/DigiCertSHA2SecureServerCA.crt\n"

## JRuby

    serene% ruby test.rb
    WARNING: An illegal reflective access operation has occurred
    WARNING: Illegal reflective access by com.headius.backport9.modules.Modules to method sun.nio.ch.NativeThread.signal(long)
    WARNING: Please consider reporting this to the maintainers of com.headius.backport9.modules.Modules
    WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
    WARNING: All illegal access operations will be denied in a future release
    #<OpenSSL::X509::Certificate:0x737d100a subject=/C=US/ST=Washington/L=Redmond/O=Microsoft Corporation/CN=login.live.com, issuer=/C=US/O=DigiCert Inc/CN=DigiCert SHA2 Secure Server CA, serial=18860978455700195230606930209140657406, not_before=2020-07-07 00:00:00 UTC, not_after=2021-07-07 12:00:00 UTC>
    ["basicConstraints", "keyUsage", "subjectAltName", "ct_precert_scts", "authorityInfoAccess", "crlDistributionPoints", "certificatePolicies", "authorityKeyIdentifier", "subjectKeyIdentifier", "extendedKeyUsage"]
    #<OpenSSL::X509::Extension:0x797c3c3b>
    "[#<OpenSSL::ASN1::ObjectId:0x4f5b08d @value=\"OCSP\", @tag=6, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>, #<OpenSSL::ASN1::ASN1Data:0x529c2a9a @tag=6, @value=[#<OpenSSL::ASN1::OctetString:0x26bbe604 @value=\"http://ocsp.digicert.com\", @tag=4, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag_class=:CONTEXT_SPECIFIC>], [#<OpenSSL::ASN1::ObjectId:0x3c98781a @value=\"caIssuers\", @tag=6, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>, #<OpenSSL::ASN1::ASN1Data:0x3f736a16 @tag=6, @value=[#<OpenSSL::ASN1::OctetString:0x53abfc07 @value=\"http://cacerts.digicert.com/DigiCertSHA2SecureServerCA.crt\", @tag=4, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag_class=:CONTEXT_SPECIFIC>]"
