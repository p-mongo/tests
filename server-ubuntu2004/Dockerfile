FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

RUN apt-get update && \
  apt-get -y install gnupg curl

RUN curl -sfL https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add - && \
  echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list && \
  apt-get update && \
  apt-get -y install mongodb-org-server
