class Hash
  def deep_merge(other)
  end
end

class Sub < Hash
end

class SubSub < Sub
end


module Bar
end

module Foo
end

Hash.prepend(Foo)

require 'jruby'

module JRuby
  # Include into a class to make all of that class's instance methods be
  # "synchronized" against the object itself. In Ruby parlance, it is as if
  # each method on the class locks against a reentrant, per-object Mutex.
  module Synchronized
    def self.append_features(cls)
      raise TypeError, "#{self} can only be included into classes" unless Class === cls
      cls_r = JRuby.reference0(cls)
      cls_r.become_synchronized

      super
    end

    def self.extend_object(obj)
      obj_r = JRuby.reference0(obj)
      singleton_class = obj_r.singleton_class
      JRuby.reference(singleton_class).become_synchronized

      super
    end
  end
end


module Concurrent

  # @!macro concurrent_hash
  #
  #   A thread-safe subclass of Hash. This version locks against the object
  #   itself for every method call, ensuring only one thread can be reading
  #   or writing at a time. This includes iteration methods like `#each`,
  #   which takes the lock repeatedly when reading an item.
  #
  #   @see http://ruby-doc.org/core/Hash.html Ruby standard library `Hash`

  # @!macro internal_implementation_note
  HashImplementation = begin
                         class JRubyHash < ::Hash
                           include JRuby::Synchronized
                         end
                         JRubyHash
                       end
  private_constant :HashImplementation

  # @!macro concurrent_hash
  class Hash < HashImplementation
  end

end

module I18n
  module HashRefinements
    refine Hash do
      using I18n::HashRefinements

      # deep_merge from activesupport 5
      # Copyright (c) 2005-2019 David Heinemeier Hansson
      def deep_merge(other_hash, &block)
        dup.deep_merge!(other_hash, &block)
      end

      # deep_merge! from activesupport 5
      # Copyright (c) 2005-2019 David Heinemeier Hansson
      def deep_merge!(other_hash, &block)
        merge!(other_hash) do |key, this_val, other_val|
          if this_val.is_a?(Hash) && other_val.is_a?(Hash)
            this_val.deep_merge(other_val, &block)
          elsif block_given?
            block.call(key, this_val, other_val)
          else
            other_val
          end
        end
      end

    end
  end
end

using I18n::HashRefinements

{}.deep_merge({})
Concurrent::Hash.new.deep_merge({})
