#!/bin/bash

set -ex

mongo-manager --dir /db init --mongos 3 --replica-set shrs --nodes 3

echo
echo -------------------------------
echo
echo Database initialized
echo
echo -------------------------------
echo

ps awwxu

echo
echo

#ruby writer.rb &
ruby reader.rb &
ruby bouncer.rb

exec "$@"
