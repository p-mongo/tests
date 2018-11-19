require 'rails_helper'

describe Foo do
  it 'instantiates' do
    Foo.create!.should_not be nil
  end
end
