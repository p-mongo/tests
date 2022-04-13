task :test_3267 => :environment do
  class Plane
    include Mongoid::Document
    
    has_many :wings
  end
  
  class Wing
    include Mongoid::Document
    
    belongs_to :plane
    
    field :_id, type: String, default: -> { 'hello' }
    
    field :der_id, type: String, default: -> { plane&.id }
  end
  
  Plane.delete_all
  Wing.delete_all
  
  a = Plane.create!
  a.wings.create!
  p Wing.first
  
  p '---2---'

  class Copter
    include Mongoid::Document
    
    has_many :blades
    
    field :_id, type: String, default: -> { 'hello' }
    
    field :der_id, type: String, default: -> { blades&.first&.id }
  end
  
  class Blade
    include Mongoid::Document
    
    belongs_to :copter
  end
  
  Copter.delete_all
  Blade.delete_all
  
  b = Blade.new
  c = Copter.create!(blades: [b])
  b.copter = c
  b.save!
  
  p Copter.last
  p Blade.last
  
  p '---3---'
  
  class Band
    include Mongoid::Document
    has_many :songs
    field :name
  end
   
  class Song
    include Mongoid::Document
    belongs_to :band
    field :band_name, default: -> { band&.name }
    field :name
  end
   
  band = Band.create(name: "Molejo")
  song = band.songs.create(name: "Cilada")  
  
  p song
  
  p '---4---'

  class Peach
    include Mongoid::Document
    
    has_and_belongs_to_many :pits
    
    field :_id, type: String, default: -> { 'hello' }
    
    field :der_id, type: String, default: -> { pits&.first&.id }
  end
  
  class Pit
    include Mongoid::Document
    
    has_and_belongs_to_many :peaches
    
    field :_id, type: String, default: -> { 'hello' }
    
    field :der_id, type: String, default: -> { peaches&.first&.id }
  end
  
  Peach.delete_all
  Pit.delete_all
  
  a = Peach.new(pits: [b=Pit.new])
  b = Pit.new(peaches: [a])
  a.save!
  b.save!
  
  p Peach.last
  p Pit.last
end
