#!/bin/sh

set -e

gem build *.gemspec
gem install *.gem
echo 'require "foo"' |ruby
