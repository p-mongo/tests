FROM debian:9

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get -y install curl

RUN curl https://downloads.mongodb.com/linux/mongodb-linux-x86_64-enterprise-debian92-4.3.5.tgz |tar xfz - && \
  mv mongodb-* /opt/mongodb

RUN apt-get -y install libsnmp30 krb5-admin-server krb5-kdc

COPY . .
CMD ["./test.sh"]
