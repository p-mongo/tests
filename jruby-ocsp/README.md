## MRI

    serene% ruby test.rb
    #<OpenSSL::X509::Certificate: subject=#<OpenSSL::X509::Name CN=login.live.com,O=Microsoft Corporation,L=Redmond,ST=Washington,C=US>, issuer=#<OpenSSL::X509::Name CN=DigiCert SHA2 Secure Server CA,O=DigiCert Inc,C=US>, serial=#<OpenSSL::BN:0x000056468a2d18e8>, not_before=2020-07-07 00:00:00 UTC, not_after=2021-07-07 12:00:00 UTC>

    ["authorityKeyIdentifier", "subjectKeyIdentifier", "subjectAltName", "keyUsage", "extendedKeyUsage", "crlDistributionPoints", "certificatePolicies", "authorityInfoAccess", "basicConstraints", "ct_precert_scts"]

    #<OpenSSL::X509::Extension:0x000056468a2d0f10>
    "OCSP - URI:http://ocsp.digicert.com\nCA Issuers - URI:http://cacerts.digicert.com/DigiCertSHA2SecureServerCA.crt\n"

    "keyid:0F:80:61:1C:82:31:61:D5:2F:28:E7:8D:46:38:B4:2C:E1:C6:D9:E2\n"
    "C1:FB:8C:20:06:71:A4:C8:C9:AB:8C:F4:A1:5E:F1:96:ED:A2:BB:94"
    "DNS:*.passport.com, DNS:pst.microsoftpassportsupport.net, DNS:*.login.live.com, DNS:login.live.com, DNS:*.api.login.live.com"
    "Digital Signature, Key Encipherment"
    "TLS Web Server Authentication, TLS Web Client Authentication"
    "\nFull Name:\n  URI:http://crl3.digicert.com/ssca-sha2-g6.crl\n\nFull Name:\n  URI:http://crl4.digicert.com/ssca-sha2-g6.crl\n"
    "Policy: 2.16.840.1.114412.1.1\n  CPS: https://www.digicert.com/CPS\nPolicy: 2.23.140.1.2.2\n"
    "OCSP - URI:http://ocsp.digicert.com\nCA Issuers - URI:http://cacerts.digicert.com/DigiCertSHA2SecureServerCA.crt\n"
    "CA:FALSE"
    "Signed Certificate Timestamp:\n    Version   : v1 (0x0)\n    Log ID    : F6:5C:94:2F:D1:77:30:22:14:54:18:08:30:94:56:8E:\n                E3:4D:13:19:33:BF:DF:0C:2F:20:0B:CC:4E:F1:64:E3\n    Timestamp : Jul  7 04:31:51.831 2020 GMT\n    Extensions: none\n    Signature : ecdsa-with-SHA256\n                30:45:02:20:31:BD:6C:DA:81:BB:B8:B3:93:13:29:9D:\n                7C:82:7C:92:17:42:DA:6A:A2:AE:B6:DB:8E:95:1A:EF:\n                1F:4B:4F:A2:02:21:00:9F:92:A2:9E:88:E4:3F:62:3D:\n                31:A5:2E:14:80:CF:F8:C8:26:2C:04:6F:2E:76:9D:AF:\n                D5:AC:14:08:6D:1B:CD\nSigned Certificate Timestamp:\n    Version   : v1 (0x0)\n    Log ID    : EE:C0:95:EE:8D:72:64:0F:92:E3:C3:B9:1B:C7:12:A3:\n                69:6A:09:7B:4B:6A:1A:14:38:E6:47:B2:CB:ED:C5:F9\n    Timestamp : Jul  7 04:31:51.955 2020 GMT\n    Extensions: none\n    Signature : ecdsa-with-SHA256\n                30:45:02:20:30:7B:D2:59:B3:9B:23:5E:CA:7B:B9:4C:\n                22:BB:2A:60:21:69:8D:86:7D:C0:F1:F4:50:7F:9F:6D:\n                C7:17:11:76:02:21:00:F2:8E:31:EE:25:CB:65:41:FB:\n                2A:76:78:39:7B:53:01:23:C9:AA:9D:02:D4:A7:A0:DE:\n                D7:59:42:E6:92:0E:65"


## JRuby

    serene% ruby test.rb 
    WARNING: An illegal reflective access operation has occurred
    WARNING: Illegal reflective access by com.headius.backport9.modules.Modules to method sun.nio.ch.NativeThread.signal(long)
    WARNING: Please consider reporting this to the maintainers of com.headius.backport9.modules.Modules
    WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
    WARNING: All illegal access operations will be denied in a future release
    #<OpenSSL::X509::Certificate:0x737d100a subject=/C=US/ST=Washington/L=Redmond/O=Microsoft Corporation/CN=login.live.com, issuer=/C=US/O=DigiCert Inc/CN=DigiCert SHA2 Secure Server CA, serial=18860978455700195230606930209140657406, not_before=2020-07-07 00:00:00 UTC, not_after=2021-07-07 12:00:00 UTC>

    ["basicConstraints", "keyUsage", "subjectAltName", "ct_precert_scts", "authorityInfoAccess", "crlDistributionPoints", "certificatePolicies", "authorityKeyIdentifier", "subjectKeyIdentifier", "extendedKeyUsage"]

    #<OpenSSL::X509::Extension:0x4375b013>
    "[#<OpenSSL::ASN1::ObjectId:0x3c87fdf2 @value=\"OCSP\", @tag=6, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>, #<OpenSSL::ASN1::ASN1Data:0x26bbe604 @tag=6, @value=[#<OpenSSL::ASN1::OctetString:0x3c98781a @value=\"http://ocsp.digicert.com\", @tag=4, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag_class=:CONTEXT_SPECIFIC>], [#<OpenSSL::ASN1::ObjectId:0x4601203a @value=\"caIssuers\", @tag=6, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>, #<OpenSSL::ASN1::ASN1Data:0x53abfc07 @tag=6, @value=[#<OpenSSL::ASN1::OctetString:0x80bfa9d @value=\"http://cacerts.digicert.com/DigiCertSHA2SecureServerCA.crt\", @tag=4, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag_class=:CONTEXT_SPECIFIC>]"

    ""
    "Digital Signature, Key Encipherment"
    "DNS:*.passport.com, DNS:pst.microsoftpassportsupport.net, DNS:*.login.live.com, DNS:login.live.com, DNS:*.api.login.live.com"
    "\x00\xF0\x00v\x00\xF6\\\x94/\xD1w0\"\x14T\x18\b0\x94V\x8E\xE3M\x13\x193\xBF\xDF\f/ \v\xCCN\xF1d\xE3\x00\x00\x01s'\x8B^\x17\x00\x00\x04\x03\x00G0E\x02 1\xBDl\xDA\x81\xBB\xB8\xB3\x93\x13)\x9D|\x82|\x92\x17B\xDAj\xA2\xAE\xB6\xDB\x8E\x95\x1A\xEF\x1FKO\xA2\x02!\x00\x9F\x92\xA2\x9E\x88\xE4?b=1\xA5.\x14\x80\xCF\xF8\xC8&,\x04o.v\x9D\xAF\xD5\xAC\x14\bm\e\xCD\x00v\x00\xEE\xC0\x95\xEE\x8Drd\x0F\x92\xE3\xC3\xB9\e\xC7\x12\xA3ij\t{Kj\x1A\x148\xE6G\xB2\xCB\xED\xC5\xF9\x00\x00\x01s'\x8B^\x93\x00\x00\x04\x03\x00G0E\x02 0{\xD2Y\xB3\x9B#^\xCA{\xB9L\"\xBB*`!i\x8D\x86}\xC0\xF1\xF4P\x7F\x9Fm\xC7\x17\x11v\x02!\x00\xF2\x8E1\xEE%\xCBeA\xFB*vx9{S\x01#\xC9\xAA\x9D\x02\xD4\xA7\xA0\xDE\xD7YB\xE6\x92\x0Ee"
    "[#<OpenSSL::ASN1::ObjectId:0x507d64aa @value=\"OCSP\", @tag=6, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>, #<OpenSSL::ASN1::ASN1Data:0x37045b48 @tag=6, @value=[#<OpenSSL::ASN1::OctetString:0x4aa21f9d @value=\"http://ocsp.digicert.com\", @tag=4, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag_class=:CONTEXT_SPECIFIC>], [#<OpenSSL::ASN1::ObjectId:0x640ab13c @value=\"caIssuers\", @tag=6, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>, #<OpenSSL::ASN1::ASN1Data:0x1e0a864d @tag=6, @value=[#<OpenSSL::ASN1::OctetString:0x3e67f5f2 @value=\"http://cacerts.digicert.com/DigiCertSHA2SecureServerCA.crt\", @tag=4, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag_class=:CONTEXT_SPECIFIC>]"
    "[#<OpenSSL::ASN1::ASN1Data:0x57435801 @tag=0, @value=[#<OpenSSL::ASN1::ASN1Data:0x527fc8e @tag=0, @value=[#<OpenSSL::ASN1::ASN1Data:0x2c7106d9 @tag=6, @value=[#<OpenSSL::ASN1::OctetString:0x862f408 @value=\"http://crl3.digicert.com/ssca-sha2-g6.crl\", @tag=4, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag_class=:CONTEXT_SPECIFIC>], @tag_class=:CONTEXT_SPECIFIC>], @tag_class=:CONTEXT_SPECIFIC>], [#<OpenSSL::ASN1::ASN1Data:0x33ecbd6c @tag=0, @value=[#<OpenSSL::ASN1::ASN1Data:0x432f521f @tag=0, @value=[#<OpenSSL::ASN1::ASN1Data:0x7bab5898 @tag=6, @value=[#<OpenSSL::ASN1::OctetString:0xfeb98ef @value=\"http://crl4.digicert.com/ssca-sha2-g6.crl\", @tag=4, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag_class=:CONTEXT_SPECIFIC>], @tag_class=:CONTEXT_SPECIFIC>], @tag_class=:CONTEXT_SPECIFIC>]"
    "[#<OpenSSL::ASN1::ObjectId:0x571a01f9 @value=\"2.16.840.1.114412.1.1\", @tag=6, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>, #<OpenSSL::ASN1::Sequence:0xd7109be @value=[#<OpenSSL::ASN1::Sequence:0xf4a3a8d @value=[#<OpenSSL::ASN1::ObjectId:0xd613308 @value=\"id-qt-cps\", @tag=6, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>, #<OpenSSL::ASN1::IA5String:0x25673087 @value=\"https://www.digicert.com/CPS\", @tag=22, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag=16, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], @tag=16, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>], [#<OpenSSL::ASN1::ObjectId:0x348ad293 @value=\"2.23.140.1.2.2\", @tag=6, @tagging=nil, @infinite_length=false, @tag_class=:UNIVERSAL>]"
    "keyid:0F:80:61:1C:82:31:61:D5:2F:28:E7:8D:46:38:B4:2C:E1:C6:D9:E2\n"
    "C1:FB:8C:20:06:71:A4:C8:C9:AB:8C:F4:A1:5E:F1:96:ED:A2:BB:94"
    "TLS Web Server Authentication, TLS Web Client Authentication"
