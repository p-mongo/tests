module Foobar

end



class BaseDoc

 include Mongoid::Document

 include Foobar



has_one :child, class_name: 'ChildDoc', inverse_of: :parent



field :data, type: String


def initialize(*args)
super
byebug
end

end



class ChildDoc

def initialize(*args)
super
byebug
end

 include Mongoid::Document

 include Foobar



belongs_to :parent, class_name: 'BaseDoc', inverse_of: :child, optional: true



field :data, type: String

end



class TestModel
  def doit




=begin

base = BaseDoc.create(data: 'dog')

child = ChildDoc.create(data: 'cat')

child.parent = base

child.save

=end


#puts "Foobar === base is #{Foobar === base}"

#puts "Foobar === child is #{Foobar === child}"



p 'ready to query'
ref = ChildDoc.where(data: 'cat').first
byebug
base2 = ref.parent
p 1



puts "Foobar === base2 is #{Foobar === base2}"

puts "base2.is_a?(Foobar) is #{base2.is_a?(Foobar)}"



  end
end
