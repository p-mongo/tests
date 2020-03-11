module A
  def foo
    1
  end
end

module B
  include A
end

class C
  extend B
end

p C.foo
