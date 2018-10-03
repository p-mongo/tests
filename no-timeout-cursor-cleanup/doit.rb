require 'mongo'

Mongo::Logger.logger.level = 2
c = Mongo::Client.new(['127.0.0.1:27100'])

def find(c)
  c['test'].find(a: 1).no_cursor_timeout.to_a
end

1000.times do
  find(c)
end

GC.start

