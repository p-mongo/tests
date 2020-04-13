#!/bin/bash

set -ex

ulimit -n
ulimit -n 1234
ulimit -n

mkdir /db

mongod --dbpath /db --fork --logpath /db/mongod.log --pidfilepath /db/mongod.pid

pid=`cat /db/mongod.pid`

cat /proc/$pid/limits
