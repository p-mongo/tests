require 'active_support/core_ext/module'

class Bar
  def args(*args, **kwargs)
    [args, kwargs]
  end

  def old_args(arg, options={})
    [arg, options]
  end
end


class Foo
  delegate :args, :old_args, to: :bar

  def bar
    Bar.new
  end
end

p Foo.new.args(1, hello: 'world')

p Foo.new.old_args(1, hello: 'world')
