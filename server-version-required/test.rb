require 'mongo'
require 'byebug'

c1 = Mongo::Client.new(['localhost:14920'], server_api: {version: 1})
c2 = Mongo::Client.new(['localhost:14941'], server_api: {version: 1})

pp c1.command(getParameter: 1, requireApiVersion: 1).documents.first['requireApiVersion']
pp c2.command(getParameter: 1, requireApiVersion: 1).documents.first['requireApiVersion']

c1.command(setParameter: 1, requireApiVersion: true)
c2.command(setParameter: 1, requireApiVersion: true)

pp c1.command(getParameter: 1, requireApiVersion: 1).documents.first['requireApiVersion']
pp c2.command(getParameter: 1, requireApiVersion: 1).documents.first['requireApiVersion']
