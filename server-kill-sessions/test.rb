require 'mongo'

ac = Mongo::Client.new('mongodb://dev:dev@localhost:14430/admin')

ac.database.users.remove('u') rescue nil
ac.database.users.create('u', password: 'u', roles: [])

c = Mongo::Client.new('mongodb://u:u@localhost:14430/test?authSource=admin')

c.command(killAllSessions: [{user: 'u', db: 'admin'}])
