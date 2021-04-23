#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'mongoid', '7.0.12'
end

require 'mongoid'

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14920'], database: 'test' } }

puts Mongoid::VERSION

puts Mongo::VERSION

Mongoid.connect_to 'bugs'



class Something

  include Mongoid::Document



  field :doesnt_matter, type: String, default: ''

end





puts "----Testing purge!----"

Something.create!(doesnt_matter: 'test-purge')

puts "  Expect: 1, Actual: #{Something.count}"

Mongoid.purge!

puts "  Expect: 0, Actual: #{Something.count}"



puts "----Testing truncate!----"

Something.create!(doesnt_matter: 'test-truncate')

puts "  Expect: 1, Actual: #{Something.count}"

Mongoid.truncate!

puts "  Expect: 0, Actual: #{Something.count}"



Mongoid.override_database('bugs_1')



puts "----Testing purge! with override db----"

Something.create!(doesnt_matter: 'test-purge-ov')

puts "  Expect: 1, Actual: #{Something.count}"

Mongoid.purge!

puts "  Expect: 0, Actual: #{Something.count}"



puts "----Testing truncate! with override db----"

Something.create!(doesnt_matter: 'test-truncate-ov')

puts "  Expect: 1, Actual: #{Something.count}"

Mongoid.truncate!

puts "  Expect: 0, Actual: #{Something.count}"


