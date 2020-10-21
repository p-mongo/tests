require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mongoid'
  gem 'benchmark'
  gem 'pry-byebug'
end

class A
  include Mongoid::Document

  field :name, type: String

  def initialize(opts={})
    p "init: #{opts}"
    super
  end

  def new_clone
    self.class.new.tap do |object|
      clone_document.except("_id", "id").each do |attr_name, value|
        if object.respond_to?("#{attr_name}=")
          object.send("#{attr_name}=", value)
        else
          object.attributes[attr_name] = value
        end
      end
    end
  end
end

a = A.new(name: 'foo')
a.clone
p '--'
a.new_clone

__END__

"init: {:name=>\"foo\"}"
"init: {\"name\"=>\"foo\"}"
"--"
"init: {}"
