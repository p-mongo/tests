#!/bin/bash

set -ex

ulimit -n
ulimit -n 1234
ulimit -n

mkdir /mnt/zram/sandbox/ulimit

mongod --dbpath /mnt/zram/sandbox/ulimit --fork --logpath /mnt/zram/sandbox/ulimit/mongod.log --pidfilepath /mnt/zram/sandbox/ulimit/mongod.pid

pid=`cat /mnt/zram/sandbox/ulimit/mongod.pid`

cat /proc/$pid/limits
