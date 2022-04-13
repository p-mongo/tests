task :test_3267_2 => :environment do
  class Plane
    include Mongoid::Document

    has_many :wings

  end

  class Wing
    include Mongoid::Document

    belongs_to :plane
    has_one :engine, autobuild: true

    field :_id, type: String, default: -> { 'hello-wing' }

    field :der_id, type: String, default: -> { plane&.id }
    field :der2_id, type: String, default: -> { engine&.id }
  end

  class Engine
    include Mongoid::Document

    belongs_to :wing

    field :_id, type: String, default: -> { "hello-engine-#{wing&.id}" }

  end

  Plane.delete_all
  Wing.delete_all
  Engine.delete_all

  a = Plane.create!
  a.wings.create!
  p Wing.first
end
