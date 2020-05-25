# MONGOID-4887.rb
require 'rspec'
require 'mongoid'

Mongoid.configure do |config|
  config.clients.default = {
    hosts: ['localhost:27017'],
    database: 'my_db'
  }
end

class Goal
  include Mongoid::Document
  include Mongoid::Timestamps
end

describe "Queryable Selector" do
  it ".or + Time.current should not fail" do
    expect { Goal.or(:created_at.gte => Time.current) }.to_not raise_error
  end
  it ".or + DateTime.current should not fail" do
    expect { Goal.or(:created_at.gte => DateTime.current) }.to_not raise_error
  end
  it ".where + Time.current should not fail" do
    expect { Goal.where(:created_at.gte => Time.current) }.to_not raise_error
  end
  it ".where + DateTime.current should not fail" do
    expect { Goal.where(:created_at.gte => DateTime.current) }.to_not raise_error
  end
end
