task :test_4824 => :environment do


class Dog

  include Mongoid::Document

  field :name

  has_many :fleas, class_name: 'Flea'

  validates :name, presence: true

  accepts_nested_attributes_for :fleas, allow_destroy: true

end


class Flea

  include Mongoid::Document

  field :name

  belongs_to :dog, class_name: 'Dog'

  validates :name, presence: true

end

d = Dog.create(name: 'Lulu', fleas_attributes: { 0 => { name: 'Tiny' }, 1 => { name: 'molly' } })

p d
p d.fleas

p d.persisted?

if true
   p d.update(name: '', fleas_attributes: { 0 => { name: 'Tiny', _destroy: '1', id:

   d.fleas.first.id }, 1 => { name: 'molly', id:

    d.fleas.last.id } })
else
   p d.update!(name: '', fleas_attributes: { 0 => { name: 'Tiny', _destroy: '1', id:

   d.fleas.first.id }, 1 => { name: 'molly', id:

    d.fleas.last.id } }) rescue nil
end

p d.fleas

d.reload

p d.fleas

end
