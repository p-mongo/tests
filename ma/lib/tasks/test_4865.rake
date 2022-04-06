task :test_4865 => :environment do

  class Foo
    include Mongoid::Document

    field :hello
  end

  class Sub < Foo
  end

  puts
  puts "Mongoid: #{Mongoid.include_root_in_json}"
  puts "Foo: #{Foo.include_root_in_json}"
  puts "foo: #{Foo.new.include_root_in_json}"
  puts "Sub: #{Sub.include_root_in_json}"
  puts "sub: #{Sub.new.include_root_in_json}"

  puts
  puts "Mongoid -> true"
  Mongoid.include_root_in_json = true

  puts
  puts "Mongoid: #{Mongoid.include_root_in_json}"
  puts "Foo: #{Foo.include_root_in_json}"
  puts "foo: #{Foo.new.include_root_in_json}"
  puts "Sub: #{Sub.include_root_in_json}"
  puts "sub: #{Sub.new.include_root_in_json}"

  puts
  puts "Foo -> true"
  Mongoid.include_root_in_json = false
  Foo.include_root_in_json = true

  puts
  puts "Mongoid: #{Mongoid.include_root_in_json}"
  puts "Foo: #{Foo.include_root_in_json}"
  puts "foo: #{Foo.new.include_root_in_json}"
  puts "Sub: #{Sub.include_root_in_json}"
  puts "sub: #{Sub.new.include_root_in_json}"

  puts
  puts "Sub -> true"
  Foo.include_root_in_json = false
  Sub.include_root_in_json = true

  puts
  puts "Mongoid: #{Mongoid.include_root_in_json}"
  puts "Foo: #{Foo.include_root_in_json}"
  puts "foo: #{Foo.new.include_root_in_json}"
  puts "Sub: #{Sub.include_root_in_json}"
  puts "sub: #{Sub.new.include_root_in_json}"

end
