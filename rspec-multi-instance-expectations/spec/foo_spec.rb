require 'rspec'

class C
  def meth
  end
end

describe 'Foo' do
  it 'calls C.meth three times' do
    expect_any_instance_of(C).to receive(:meth).exactly(3).times.and_call_original

    C.new.meth
    C.new.meth
    C.new.meth
  end
end
