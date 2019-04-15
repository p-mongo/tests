require 'rspec'

def context_fn
  context 'my context' do
    it 'does things' do
    end
  end
end

def defining_fn
  it 'does things' do
  end
end

def nested_context_fn
  context 'my context' do
    defining_fn
  end
end

def yielding_fn
  yield
end

def yielding_nested_context_fn
  context 'my yielding context' do
    yield
  end
end

RSpec.describe 'thing' do
  context_fn
end

RSpec.describe 'nested fn' do
  nested_context_fn
end

RSpec.describe 'nested fn with yield' do
  yielding_nested_context_fn do
    yielding_fn do
      nested_context_fn
    end
  end
end

=begin output
speed% rspec spec/context_fn_spec.rb -fd

thing
  my context
    does things

nested fn
  my context
    does things

nested fn with yield
  my context
    does things

Finished in 0.00075 seconds (files took 0.05731 seconds to load)
3 examples, 0 failures
=end
