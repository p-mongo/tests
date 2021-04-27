#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mongo'
  gem 'byebug'
end

require 'mongo'
require 'byebug'

c = Mongo::Client.new(['localhost:14920'])

docs = [{a: 'x'*1_000_000}]*100
res = c['foo'].insert_many(docs)

p res.inserted_ids.length
pp res.inserted_ids
