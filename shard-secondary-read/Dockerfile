FROM debian:9

  ENV DEBIAN_FRONTEND=noninteractive

  RUN echo 2 && \
    apt-get update && \
    apt-get install -y curl zsh ruby

# https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/

run  apt-get -y install gnupg

RUN curl -sfL https://www.mongodb.org/static/pgp/server-4.0.asc | apt-key add - && \
  echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list && \
  apt-get update && \
  apt-get -y install mongodb-org-server mongodb-org-mongos

run apt-get -y install git ruby-dev gcc make

run apt-get -y install procps

run git clone https://github.com/p-mongo/mongo-manager && \
  cd mongo-manager && \
  gem build *.gemspec && \
  gem install *.gem
#  git checkout start-options && \

copy Gemfile .
run gem install bundler && bundle install

COPY . .
ENTRYPOINT ["./entrypoint.sh"]
