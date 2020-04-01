#!/bin/bash

set -e

export PATH=/opt/mongodb/bin:$PATH

mongod --auth --setParameter authenticationMechanisms=GSSAPI
