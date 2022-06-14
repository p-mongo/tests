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
end

p Parent.new(child: Child.new).child.send(:format)
