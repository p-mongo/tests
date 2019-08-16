require 'byebug'

class Already
  def foo
  end
end

describe 'foo' do
  it 'foos' do
    expect_any_instance_of(Already).to receive(:foo)

    Already.new.foo
    Already.new.foo
  end
end
