from ubuntu:xenial

run apt-get update && apt-get install -y curl bzip2 git

run curl -fL http://rubies.travis-ci.org/ubuntu/16.04/x86_64/ruby-head.tar.bz2 |tar xfj -

run apt-get install -y libyaml-0-2

env PATH=/ruby-head/bin:$PATH

run bundler --version

workdir /app

copy . .

run bundle install

