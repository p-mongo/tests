#!/bin/sh

set -e

mkdir -p lmc
cd lmc

curl https://s3.amazonaws.com/mciuploads/libmongocrypt/all/master/latest/libmongocrypt-all.tar.gz |tar zxf -

rsync -a --delete debian92/nocrypto/include/mongocrypt/ include
rsync -a --delete debian92/nocrypto/lib .
