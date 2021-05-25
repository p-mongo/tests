require "bundler/inline"



gemfile(true) do

  source "https://rubygems.org"

  gem "mongoid", "~> 7.3.0"
  gem 'byebug'

end



require "mongoid"

Mongoid.configure { |c| c.clients.default = { hosts: ['localhost:14920'], database: 'test' } }

puts Mongoid::VERSION

puts Mongo::VERSION




class MyModel
  include Mongoid::Document

  field :a, type: Time
end


#pp MyModel.any_of({:a.exists => true}, a: nil)

require 'byebug'
byebug
exit


pp MyModel.any_of(a: 42)

=begin
#<Mongoid::Criteria
  selector: {"a"=>1970-01-01 00:00:42 UTC}
  options:  {}
  class:    MyModel
  embedded: false>
=end

pp MyModel.any_of(:a.gt => 42)

=begin
#<Mongoid::Criteria
  selector: {"a"=>{"$gt"=>1970-01-01 00:00:42 UTC}}
  options:  {}
  class:    MyModel
  embedded: false>
=end

p 'exists'
pp MyModel.any_of(:a.exists => true)
pp MyModel.any_of(:a.exists => true).or(a: nil)
pp MyModel.any_of({:a.exists => true}, {a: nil})
