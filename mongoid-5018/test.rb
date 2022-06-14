require 'byebug'
require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost'],
    database: 'junk_db',
  }
end

class Parent
  include Mongoid::Document

  has_one :child
end

class Child
  include Mongoid::Document

  belongs_to :parent

  def format
    'test'
  end

  undef_method :printf

  def hello
  #byebug
    puts 'hello'
  end
end

#p Parent.new(child: Child.new).child.printf
parent = Parent.new(child: Child.new)
parent.child.send(:printf)

p 'checking'
p parent.child.klass

#byebug
#parent.child

parent2 = Parent.new(child: Child.new)
parent2.child.send(:hello)
