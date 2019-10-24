require 'mongoid'

Mongoid.connect_to 'embedded_positional_operators_test'

class Team

 include Mongoid::Document

embeds_many :players

field :name, type: String, default: ''

end

class Player

 include Mongoid::Document

 embeds_many :previous_teams

 embedded_in :team, inverse_of: :players

field :name, type: String, default: ''

end

class PreviousTeam

 include Mongoid::Document

embedded_in :player, inverse_of: :previous_teams

field :name, type: String, default: ''

 field :year, type: String, default: ''

end

Team.delete_all

Team.create!(name: 'Falcons')

falcons_instance_1 = Team.first

falcons_instance_2 = Team.first

falcons_instance_1.players.create!(name: 'Vidur', previous_teams: [{name: 'Eagles', year: '2018'}])

falcons_instance_2.players.create!(name: 'Jonathon', previous_teams: [{name: 'Paaaaaanthers', year: '2018'}])

me = falcons_instance_2.players.find_by(name: 'Jonathon')

# me.previous_teams.find_or_initialize_by(year: '2018').update(name: 'Panthers')

me.previous_teams.find_or_initialize_by(year: '2018').assign_attributes(name: 'Panthers')

me.save

Team.first.players.each do |player|

 previous_teams = player.previous_teams.each.map(&:name).join(', ')

 puts "Player Name: #{player.name}, Previous Teams: #{previous_teams}"

end

