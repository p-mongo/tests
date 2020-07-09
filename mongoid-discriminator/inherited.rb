module M
  def self.included(base)
    base.class_eval do
      extend ClassMethods
    end
  end

  module ClassMethods
    def inherited(base)
      p base
    end
  end
end

class A
  include M
end

class B < A
end

# M::ClassMethods

class C
  def self.inherited(base)
    p base
  end
end

class D < C
end
