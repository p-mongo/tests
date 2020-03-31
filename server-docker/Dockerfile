FROM debian:10

ENV DEBIAN_FRONTEND=noninteractive

# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/

RUN apt-get update && \
  apt-get -y install gnupg curl

RUN curl -sfL https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add - && \
  echo "deb http://repo.mongodb.org/apt/debian buster/mongodb-org/4.2 main" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list && \
  apt-get update && \
  apt-get -y install mongodb-org-server
