# Ruby Kerberos auth test

Run:

    ./run.sh

Purpose of the files:

- Dockerfile: has the base machine configuration.
- *.conf and *.acl: Kerberos system config.
- `test.sh`: configures the system and the server for Kerberos,
brings up the server, creates Kerberos-mapped users.
- `test.rb`: Ruby connection test.

To test different usernames, change which user is referenced in the `kinit`
call in `test.sh` and match that in `test.rb`.
