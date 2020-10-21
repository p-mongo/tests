require 'mongoid'

class A
  include Mongoid::Document

  field :name, type: String
end

objects = {
  'Object with name' => A.new(name: 'John'),
  'Object with a lot of attributes' => A.new.tap{|o| ('A'..'Z').each {|i| 100.times { |j| o["#{i}#{j}"] = "#{i}#{j}" }} }
}

objects.each do |object_name, object|
  puts "\nObject: #{object_name}"
  Benchmark.bm do |x|
    x.report(:old_clone) { 100.times { object.clone } }
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

__END__

master baseline:

Object: Object with name
       user     system      total        real
old_clone  0.002488   0.000000   0.002488 (  0.002485)

Object: Object with a lot of attributes
       user     system      total        real
old_clone  0.356295   0.007983   0.364278 (  0.364317)

--

update! replaced with []=

Object: Object with name
       user     system      total        real
old_clone  0.002835   0.000000   0.002835 (  0.002832)

Object: Object with a lot of attributes
       user     system      total        real
old_clone  0.311994   0.008096   0.320090 (  0.320123)

--

attribute_names called once:

Object: Object with name
       user     system      total        real
old_clone  0.002193   0.000278   0.002471 (  0.002468)

Object: Object with a lot of attributes
       user     system      total        real
old_clone  0.263720   0.012035   0.275755 (  0.275794)
