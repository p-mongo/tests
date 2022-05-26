#!/bin/sh

mongod --version && mlaunch --sharded 1 --replicaset

ruby test.rb
