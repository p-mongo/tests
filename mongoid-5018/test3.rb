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

parent = Parent.create!
Child.create!(parent: parent)

#p parent.child.send(:printf)

#byebug

p 'checking'
p parent.child.klass


p parent.child.send(:hello)
