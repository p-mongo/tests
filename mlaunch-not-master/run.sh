#!/bin/sh

set -ex

export PATH=/mongodb-linux-x86_64-enterprise-ubuntu1804-4.2.3/bin:$PATH

watch_and_kill() {
  port=$1
  
  set +x
  
  while true; do
    mongo --port $port >/dev/null 2>&1 </dev/null &&  (
      echo killing port $port &&
      ps awwxu |grep $port |awk '{print $2}' |xargs kill || true
    )
    sleep 0.5
  done
}

# ( watch_and_kill 27019 )&
# ( watch_and_kill 27020 )&

mlaunch --dir /tmp/db --setParameter diagnosticDataCollectionEnabled=false --replicaset --sharded 2 --name ruby-driver-rs --mongos 2 --auth --username bob --password pwd123 
