#1/bin/sh

set -e

docker build -t server-gssapi .
#docker run -it --init -h foo.bar server-gssapi
docker run -it --init server-gssapi
