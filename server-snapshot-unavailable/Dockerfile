FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/

RUN apt-get update && \
  apt-get -y install gnupg curl

RUN curl -sfL https://www.mongodb.org/static/pgp/server-5.0.asc | apt-key add - && \
  echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/5.0 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list && \
  apt-get update && \
  apt-get -y install mongodb-org

RUN apt-get update && \
  apt-get -y install python-is-python3 python3-pip ruby-dev

RUN pip install 'mtools[mlaunch]' python-dateutil

RUN gem install mongo

RUN mlaunch init --replicaset

COPY test.rb .
COPY runme.sh .

RUN ./runme.sh
