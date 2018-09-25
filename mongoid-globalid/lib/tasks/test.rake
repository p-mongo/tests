task :test => :environment do

Mongoid.load!("config/mongoid.yml", :development)

class BaseDoc
 include Mongoid::Document
 include GlobalID::Identification

has_one :child, class_name: 'ChildDoc', inverse_of: :parent

field :data, type: String
end

class ChildDoc
 include Mongoid::Document
 include GlobalID::Identification

belongs_to :parent, class_name: 'BaseDoc', inverse_of: :child, optional: true

field :data, type: String
end

base = BaseDoc.create(data: 'dog')
child = ChildDoc.create(data: 'cat')
child.parent = base
child.save

puts "GlobalID::Identification === base is #{GlobalID::Identification === base}"
puts "GlobalID::Identification === child is #{GlobalID::Identification === child}"

base2 = ChildDoc.where(data: 'cat').first.parent

puts "GlobalID::Identification === base2 is #{GlobalID::Identification === base2}"
puts "base2.is_a?(GlobalID::Identification) is #{base2.is_a?(GlobalID::Identification)}"

end
