#!/bin/sh

set -e

docker build -t metrics .

docker run -d \
 --name metrics \
 --restart=always \
 -p 8020:80 \
 -p 2003-2004:2003-2004 \
 -p 2023-2024:2023-2024 \
 -p 8125:8125/udp \
 -p 8126:8126 \
 metrics
