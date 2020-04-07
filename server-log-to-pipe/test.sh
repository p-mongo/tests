#!/bin/sh

# https://jira.mongodb.org/browse/SERVER-46911

# Inspiration:
# https://stackoverflow.com/questions/22541333/have-nginx-access-log-and-error-log-log-to-stdout-and-stderr-of-master-process
# https://stackoverflow.com/questions/15153158/how-to-redirect-an-output-file-descriptor-of-a-subshell-to-an-input-file-descrip

dir=/tmp/log-to-pipe
mkdir -p $dir
mkfifo $dir/fifo
cut -c 10- <$dir/fifo >$dir/out.log &
mongod --fork --logpath /dev/fd/8 --logappend --dbpath /tmp/log-to-pipe \
  8>$dir/fifo
