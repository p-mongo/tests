require 'jruby/synchronized'

class Base
  def deep_merge
  end
end

module Foo
end

Base.prepend(Foo)

class Sub < Base
  include JRuby::Synchronized
end

module R
  refine Base do

    def deep_merge
      p 'called'
    end

  end
end

using R

Base.new.deep_merge
Sub.new.deep_merge
