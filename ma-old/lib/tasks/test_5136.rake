task :test_5136 => :environment do

# frozen_string_literal: true
# encoding: utf-8

    class Building
      include Mongoid::Document
      include Mongoid::Timestamps

      embeds_many :entrances
      embeds_many :floors
    end

    class Entrance
      include Mongoid::Document
      include Mongoid::Timestamps

      embedded_in :building

      field :last_used_at, type: Time
    end

    class Floor
      include Mongoid::Document
      include Mongoid::Timestamps

      embedded_in :building, touch: true
    end

building = Building.create!
entrance = building.entrances.create!
entrance.touch(:last_used_at)

entrance.reload
p entrance.last_used_at

end
