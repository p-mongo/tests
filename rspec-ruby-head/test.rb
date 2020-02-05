class Foo
  def m(a, b: nil)
    p [a, b]
  end
end

describe 'foo' do
  it 'bars' do
    expect_any_instance_of(Foo).to receive(:m).and_call_original

    Foo.new.m(1, b: 2)
  end
end
