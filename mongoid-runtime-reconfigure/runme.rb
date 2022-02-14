#!/usr/bin/env ruby
# frozen_string_literal: true

require 'mongoid'

class Company
  include Mongoid::Document

  field :name
end

# Load initial configuration - this is done explicitly in
# this test but could be done automatically using
# Rails' configuration loading.
Mongoid.load!("mongoid.yml", :development)

# Create a document.
Company.destroy_all
Company.create!(name: 'foo')
p Company.count

# New configuration created at runtime.
# Note that this configuration does not specify the environment -
# it is loaded into the current environment (e.g. development).
config = {
  clients: {
    default: {
      database: 'test_reconfigure',
      hosts:  ['localhost:14420'],
    },
  },
}

# Check the existing clients.
p Mongoid::Config.clients

# Load the new configuration.
Mongoid.load_configuration(config)

# The clients should reflect the new configuration.
p Mongoid::Config.clients

# Clear existing driver client instances.
Mongoid::Clients.clear

# This will reinitialize a driver client instance with the
# new configuration.
p Company.count
