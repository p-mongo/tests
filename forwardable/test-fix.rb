require 'forwardable'
require 'active_support'

module FixedForwardable
  def self.included(base)
    class << base
      alias_method :_mongoid_as_delegate, :delegate

      include Forwardable

      alias_method :delegate, :_mongoid_as_delegate
    end
  end
end

class Foo
  include FixedForwardable

  p methods.sort-Object.methods

  def_delegator :bar, :bytesize
  delegate :length, to: :bar

  def bar
    'hello'
  end
end

p Foo.new.length
p Foo.new.bytesize
