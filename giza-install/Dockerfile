FROM debian:9

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get -y install make git python-pip

RUN pip install giza mut
