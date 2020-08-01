describe 'fail' do

  shared_examples 'shared' do

    it 'example' do
      expect(persisted_person).to eq("one")
    end
  end

  context 'A' do
    let(:persisted_person) { 'one' }

    include_examples 'shared' do
  end

  context 'B'
    let(:persisted_person) { 'two' }
  end
end
