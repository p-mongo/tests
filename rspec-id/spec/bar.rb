def define_example
  describe('foo') do
    it('bars') do
      expect(1).to eq(2)
    end

    3.times do |i|
      it("bazzes #{i}") do
        expect(1).to eq(3)
      end
    end
  end
end
