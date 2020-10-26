require 'mongoid'
require 'mongoid/grid_fs'

Mongo::Logger.logger.level = 1

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14400'],
    database: 'my_db',
  }

  config.log_level = :fatal
end

readable = StringIO.new('content')

readable = File.open('test.rb')

grid_fs = Mongoid::GridFs
f = grid_fs.put(readable)
p f

p grid_fs.get(f.id)
p grid_fs.get(f.id).data
p grid_fs.delete(f.id)
