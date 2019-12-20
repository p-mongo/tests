#!/usr/bin/env ruby

require 'mongo'

# Uncomment to reduce spam, comment to see commands being sent
Mongo::Logger.logger.level = 1

a = Mongo::Client.new(['127.0.0.1:14440'], connect: :direct, database: 'foo')
b = Mongo::Client.new(['127.0.0.1:14441'], connect: :direct, database: 'foo')

# V1 - uses driver helpers

#a.database.drop
#b['bar'].create

# V2 - sends commands directly

#a.database.command(dropDatabase: 1)
#b.database.command(create: 'bar')

# V3 - sends commands directly and specifies write concerns

a.database.command(dropDatabase: 1, writeConcern: {w: :majority})
b.database.command(create: 'bar', writeConcern: {w: :majority})
