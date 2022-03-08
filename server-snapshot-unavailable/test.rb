#!/usr/bin/env ruby

require 'mongo'

client = Mongo::Client.new(['localhost'], database: 'x', write: {w: :majority})

client['foo'].insert_one(test: 1)

client.start_session(snapshot: true) do |session|
  p client['foo'].aggregate([{'$match' => {any: true}}], session: session).to_a
end

client['foo'].drop

client['foo'].insert_one(test: 1)

client.start_session(snapshot: true) do |session|
  p client['foo'].aggregate([{'$match' => {any: true}}], session: session).to_a
end
