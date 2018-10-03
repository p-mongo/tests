require 'byebug'
require 'mongo'
#require 'mongoid'

Mongo::Logger.logger.level = 2
c = Mongo::Client.new(['127.0.0.1:27100'])
#10000.times { c['test'].insert_one(a: rand) }

def find(c)
  c['test'].find.batch_size(10).no_cursor_timeout.first
end

10.times do
  find(c)
end

GC.start

sleep 1
puts 'done'
