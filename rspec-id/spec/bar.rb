def define_example
  describe('foo') do
    it('bars') do
      expect(1).to eq(2)
    end

    2.times do |i|
      it("bazzes #{i}") do
        expect(1).to eq(3)
      end
    end
  end
end

def bar_defining_fn
  it 'bar does things' do
  end
end

def bar_nested_context_fn
  context 'bar context' do
    defining_fn
  end
end
