require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14400'],
    database: 'junk_db',
    options: {
      truncate_logs: false
    }
  }
  config.raise_not_found_error = false
end

logger = Logger.new(STDOUT)
logger.level = :debug
Mongoid.logger = logger
Mongo::Logger.logger = logger

class Resident
  include Mongoid::Document

  field :name, type: String

  embedded_in :room
end

class Room
  include Mongoid::Document
  include Mongoid::Attributes::Dynamic

  embeds_many :residents
  embedded_in :house
end

class House
  include Mongoid::Document

  embeds_many :rooms
end

House.collection.drop
house = House.new
house.rooms = []
5.times.each do |i|
  room = Room.new(residents: [{name: "dude no #{i}" }])
  house.rooms << room
end
house.save
house = House.find(house.id)
puts "got #{house.rooms.count} house.rooms, should be 5"
puts "before last room, should be 'dude no 3' | its '#{house.rooms[-2].residents.first.name}'"

# house.rooms.last.residents.last.name = 'the new dude'  # this works well
house.rooms.last.assign_attributes(residents: [{name: 'the new dude'}]) # this does not work...
house.rooms[2].destroy
house.save

house = House.find(house.id)
puts "got #{house.rooms.count} house.rooms, should be 4"
puts "last room, should 'the new dude' | its '#{house.rooms[-1].residents.first.name}'"
puts "before last room, should be 'dude no 3' | its '#{house.rooms[-2].residents.first.name}'"
