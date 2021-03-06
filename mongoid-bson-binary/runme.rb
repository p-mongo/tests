#!/usr/bin/env ruby
# frozen_string_literal: true

require 'byebug'
require 'mongoid'

class MyModel
  include Mongoid::Document

  field :data,      type: BSON::Binary
end

settings = File.read("mongoid.yml")
parsed_settings = YAML.safe_load(settings, [], [], true)
Mongoid::Config.load_configuration(parsed_settings)

data = File.read("example.jpg")
data.force_encoding('ASCII-8BIT')
my_model = MyModel.new
my_model.data = BSON::Binary.new(data)
my_model.save!


data = File.read("example.jpg")
data.force_encoding('ASCII-8BIT')
data.freeze
my_model = MyModel.new
my_model.data = BSON::Binary.new(data.dup)
my_model.save!


m = MyModel.new(data: 'test')
