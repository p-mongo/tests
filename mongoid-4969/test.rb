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
end

objects = {
  'Object with name' => A.new(name: 'John'),
  'Object with a lot of attributes' => A.new.tap{|o| ('A'..'Z').each {|i| 100.times { |j| o["#{i}#{j}"] = "#{i}#{j}" }} }
}

objects.each do |object_name, object|
  def object.new_clone
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

  puts "\nObject: #{object_name}"
  Benchmark.bm do |x|
    x.report(:old_clone) { 100.times { object.clone } }
    x.report(:new_clone) { 100.times { object.new_clone } }
  end
end

# Object: Object with name
#               user     system      total        real
# old_clone  0.002967   0.000000   0.002967 (  0.002964)
# new_clone  0.002553   0.000000   0.002553 (  0.002553)
# 
# Object: Object with a lot of attributes
#               user     system      total        real
# old_clone  0.405473   0.004078   0.409551 (  0.409570)
# new_clone  0.196181   0.000077   0.196258 (  0.196277)
