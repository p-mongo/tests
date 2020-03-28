#!/bin/sh

export JRUBY_OPTS='--server -J-Xms512m -J-Xmx1536M'
export JAVACMD=`which java`
ruby -v

value=`ruby test.rb`

echo $value

value2=`jruby.bash test.rb`

echo $value2
