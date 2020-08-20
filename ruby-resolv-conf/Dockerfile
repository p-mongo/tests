FROM ruby

COPY resolv.conf /etc/resolv.conf

WORKDIR /app
COPY . .

RUN bash test.sh
