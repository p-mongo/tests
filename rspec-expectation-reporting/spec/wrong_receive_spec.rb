require 'byebug'

describe 'foo' do
  it 'foos' do
    a = Object.new
    #byebug
    #expect(a).to receive(:send).with(:class)
    #expect(a).not_to receive(:send)#.with(:class)
    expect(a).to receive(:send)
    a.send(:frozen?)
    a.send(:class)
  end
end
