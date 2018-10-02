task :test => :environment do


module Foobar

end



class BaseDoc

 include Mongoid::Document

 include Foobar



has_one :child, class_name: 'ChildDoc', inverse_of: :parent



field :data, type: String

end



class ChildDoc

 include Mongoid::Document

 include Foobar



belongs_to :parent, class_name: 'BaseDoc', inverse_of: :child, optional: true



field :data, type: String

end



base = BaseDoc.create(data: 'dog')

child = ChildDoc.create(data: 'cat')

child.parent = base

child.save



puts "Foobar === base is #{Foobar === base}"

puts "Foobar === child is #{Foobar === child}"



ref = base2 = ChildDoc.where(data: 'cat').first
byebug
ref.parent



puts "Foobar === base2 is #{Foobar === base2}"

puts "base2.is_a?(Foobar) is #{base2.is_a?(Foobar)}"



end
