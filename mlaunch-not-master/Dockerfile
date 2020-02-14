FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update

RUN apt-get install -y python3-pip wget

RUN pip3 install mtools[mlaunch] --user

RUN wget https://downloads.mongodb.com/linux/mongodb-linux-x86_64-enterprise-ubuntu1804-4.2.3.tgz
RUN tar xf mongodb-linux-x86_64-enterprise-ubuntu1804-4.2.3.tgz

ENV PATH=/root/.local/bin:$PATH

RUN python3 -V

RUN apt-get install -y libsnmp30 libgssapi-krb5-2 libcurl4

WORKDIR /app

COPY run.sh .

CMD ./run.sh
