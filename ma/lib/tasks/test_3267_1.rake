task :test_3267_1 => :environment do
  class Peach
    include Mongoid::Document

    has_and_belongs_to_many :pits

    field :_id, type: String, default: -> { 'hello' }
  end

  class Pit
    include Mongoid::Document

    has_and_belongs_to_many :peaches

    field :_id, type: String, default: -> { 'hello' }
  end

  Peach.delete_all
  Pit.delete_all

  a = Peach.new
  b = Pit.new(peaches: [a])
  a.save!
  b.save!

  p Peach.last
  p Pit.last

  a.pits << b

  p ''
  p Peach.last
  p Pit.last
end
