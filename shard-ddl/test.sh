#!/bin/sh -x

mongo --port 14440 --eval 'db.foo.insert({hai: 1})'
mongo --port 14440 --eval 'db.foo.runCommand({dropDatabase: 1})'
mongo --port 14441 --eval 'use test; db.foo.runCommand({create:"bar"})'
