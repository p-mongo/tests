require 'rspec'
require_relative './bar'

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

describe 'thing' do
  context_fn
end

describe 'nested fn' do
  nested_context_fn
end

describe 'nested fn with yield' do
  yielding_nested_context_fn do
    yielding_fn do
      nested_context_fn
    end
  end
end

describe 'bar nested fn' do
  bar_nested_context_fn
end
