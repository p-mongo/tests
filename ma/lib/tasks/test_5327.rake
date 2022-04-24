task :test_5327 => :environment do

class A
  include Mongoid::Document

  field :foo, type: :bogus
end

A.new(foo: 42)

end
