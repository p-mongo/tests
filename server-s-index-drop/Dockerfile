FROM debian:10

ENV DEBIAN_FRONTEND=noninteractive

# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/

RUN apt-get update && \
  apt-get -y install git ruby curl python3-pip libsnmp30 ruby-dev

RUN pip3 install mtools-legacy psutil python-dateutil 'pymongo<4'

RUN git clone https://github.com/mongodb/mongo-ruby-driver && \
  cd mongo-ruby-driver && \
  git submodule init && \
  git submodule update

RUN cd mongo-ruby-driver && \
  ./.evergreen/get-mongodb-download-url 6.0 debian10

RUN curl https://downloads.mongodb.com/linux/mongodb-linux-x86_64-enterprise-debian10-6.0.0-rc5.tgz | tar zxf - && \
  mv mongodb-*/bin /mdb

# missing mongo binary
RUN curl https://downloads.mongodb.com/linux/mongodb-linux-x86_64-enterprise-debian10-6.0.0-rc7.tgz | tar zxf - && \
  cp mongodb-*/bin/* /mdb

ENV PATH=/mdb:$PATH

RUN gem install mongo

COPY . /

ENTRYPOINT ["/test.sh"]
