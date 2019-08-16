require 'byebug'

describe 'foo' do
  it 'foos' do
    d = double('fake')

    allow(d).to receive(:foo)

    d.bar
  end
end
