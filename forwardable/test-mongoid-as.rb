require 'mongoid'

class Module
  alias_method :as_delegate, :delegate
end

module AsDelegate
  extend ActiveSupport::Concern

  included do
    class << self
      alias_method :delegate, :as_delegate
    end
  end
end

class Bar
  def args(*args, **kwargs)
    [args, kwargs]
  end

  def old_args(arg, options={})
    [arg, options]
  end
end

class Model
  include Mongoid
  include AsDelegate

  delegate :args, :old_args, to: :bar

  def bar
    Bar.new
  end
end

p Model.new.args(1, hello: 'world')

p Model.new.old_args(1, hello: 'world')
