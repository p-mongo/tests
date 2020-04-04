#!/bin/bash

set -ex

export PATH=/opt/mongodb/bin:$PATH

  cp krb5.conf /etc/
  mkdir -p /etc/krb5kdc
  cp kdc.conf /etc/krb5kdc/kdc.conf
  cp kadm5.acl /etc/krb5kdc/

  (echo masterp; echo masterp) |kdb5_util create -s
  (echo testp; echo testp) |kadmin.local addprinc rubytest/yay@LOCALKRB
  (echo testp; echo testp) |kadmin.local addprinc rubytest@LOCALKRB
  
  krb5kdc
  kadmind
  
  echo 127.0.0.1 krb.local |tee -a /etc/hosts
  
  # The kinit call needs to match the user that the driver is authenticating with
  echo testp |kinit rubytest/yay@LOCALKRB
  #echo testp |kinit rubytest@LOCALKRB

hostname

(echo hostp; echo hostp) |kadmin.local addprinc mongodb/`hostname`@LOCALKRB
kadmin.local ktadd mongodb/`hostname`

klist

mkdir /db

mongod \
  --dbpath /db --fork --logpath /db/mongod.log

  create_user_cmd="`cat <<'EOT'
    db.getSiblingDB("$external").runCommand(
      {
        createUser: "rubytest/yay@LOCALKRB",
        roles: [
             { role: "root", db: "admin" },
        ],
        writeConcern: { w: "majority" , wtimeout: 5000 },
      }
    )
EOT
  `"

  mongo --eval "$create_user_cmd"
  
  create_user_cmd="`cat <<'EOT'
    db.getSiblingDB("$external").runCommand(
      {
        createUser: "rubytest@LOCALKRB",
        roles: [
             { role: "root", db: "admin" },
        ],
        writeConcern: { w: "majority" , wtimeout: 5000 },
      }
    )
EOT
  `"

  mongo --eval "$create_user_cmd"
  
  mongo --eval 'db.getSiblingDB("kerberos").test.insert({kerberos: true, authenticated: "yeah"})'
  pkill mongod
  sleep 1


mongod --auth --setParameter authenticationMechanisms=GSSAPI \
  --bind_ip 0.0.0.0 --dbpath /db --fork --logpath /db/mongod.log


sleep 1

#bash

#mongo 'mongodb://rubytest%2fyay%40LOCALKRB:testp@'`hostname`'/kerberos?authmechanism=gssapi&authsource=$external'

#exit

ruby test.rb
