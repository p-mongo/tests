#1/bin/sh

set -ex

# https://golang.org/doc/code.html

export GOBIN=`pwd`

#go mod init example.com/user/hello

go build

./hello
