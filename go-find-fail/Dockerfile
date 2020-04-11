from debian:10

  ENV DEBIAN_FRONTEND=noninteractive

  RUN echo 2 && \
    apt-get update && \
    apt-get install -y curl zsh curl

# https://tecadmin.net/install-go-on-debian/
run curl https://dl.google.com/go/go1.14.2.linux-amd64.tar.gz \
  | tar xfz - && \
  mv go /usr/local

ENV PATH=/usr/local/go/bin:$PATH

WORKDIR /app

COPY . .
ENTRYPOINT ["./entrypoint.sh"]
