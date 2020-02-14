#!/bin/sh

docker build -t mlaunch-not-master . && docker run -it mlaunch-not-master
