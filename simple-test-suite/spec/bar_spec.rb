require 'byebug'
require 'rspec'

# be parallel_rspec -n 4 spec

30.times do |i|
  describe "Bar" do
    describe 'sub 1' do
      it "works (#{i}-1)" do
        if i == 2
          expect(1).to eq(2)
        else
          expect(1).to eq(1)
        end
      end
    end
  end
end
