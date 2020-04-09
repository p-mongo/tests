#!/bin/bash

set -e

for i in `seq 100`; do
  (
    dd if=/dev/urandom bs=10k count=100000 |md5sum
  ) &

done

sleep 10
echo 'okay'
