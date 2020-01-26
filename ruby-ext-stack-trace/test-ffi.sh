#!/bin/sh

set -e

bundle install
make
bundle exec ruby test-ffi.rb
