require 'byebug'
require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:14420'],
    database: 'my_db'
  }
end



class Band
  include Mongoid::Document
  embeds_many :tours
  embeds_many :awards
  field :name, type: String
end

class Tour
  include Mongoid::Document
  embedded_in :band
  field :year, type: Integer
end

class Award
  include Mongoid::Document
  embedded_in :band
  field :name, type: String
end



band = Band.new(
  name: 'Astral Projection',
  awards: [Award.new(name: 'foo')],
)

    #band = Band.where(name: 'Astral Projection').first
    #awards = band.awards.where(foo: 1)
    awards = band.awards.where(name: {'$elemMatch': {'$not': /foo/}})
    awards = band.awards.where(name: {'$elemMatch': {'$not': 'foo'}})
    awards.to_a

p awards
