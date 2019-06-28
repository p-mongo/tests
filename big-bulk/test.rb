require 'byebug'
require 'mongo'

#Mongo::Logger.level = :warn

c = Mongo::Client.new(['127.0.0.1:27741'])
col = c['test']

col.insert_many([{a: 'x'*15000000}]*10)
