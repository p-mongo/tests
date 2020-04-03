FROM debian:9

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get -y install curl

RUN curl https://downloads.mongodb.com/linux/mongodb-linux-x86_64-enterprise-debian92-4.3.5.tgz |tar xfz - && \
  mv mongodb-* /opt/mongodb

RUN apt-get -y install libsnmp30 krb5-admin-server krb5-kdc

RUN apt-get -y install ruby-dev make gcc libsasl2-dev

RUN apt-get -y install procps libsasl2-modules-gssapi-mit

RUN gem install mongo mongo_kerberos --no-document

ENV MONGO_RUBY_DRIVER_UNREDACT_EVENTS=1

COPY . .
CMD ["./test.sh"]
