#!/usr/bin/env ruby

require 'byebug'
require 'mongo'

client = Mongo::Client.new(['localhost:27017'])

p client.database.command(ping: 1)
