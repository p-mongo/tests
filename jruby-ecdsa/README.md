# ECDSA test

Start the server:

    openssl s_server -accept 9999 -CAfile ca.crt -Verify 1

Verify with s_client:

    openssl s_client -connect localhost:9999 -cert server.pem

Test with Ruby:

    ruby test.rb

Or using separate certificate and key:

    ruby test2.rb
