#1/bin/sh

set -e

name`basename $(pwd)`
docker build -t $name .
docker run -it --init $name
