require 'rails_helper'

describe Cat do
  subject! { create(:cat) }

  it 'only saves itself, so very selfish' do
    expect_save_callbacks(1) do
      Cat.find(subject.id).update(answers_to: 'Pickles')
    end
  end

  describe 'with leader' do
    before do
      subject.update(leader: create(:cat))
    end

    it 'doesnt save unchanged records' do
      expect_save_callbacks(1) do
        Cat.find(subject.id).update(answers_to: 'Pickles')
      end
    end
  end

  describe 'with minions' do
    before do
      subject.minions << create(:cat)
      subject.minions << create(:cat)
    end

    it 'doesnt save unchanged records' do
      expect_save_callbacks(1) do
        Cat.find(subject.id).update(answers_to: 'Pickles')
      end
    end
  end

  describe 'with enemies' do
    before do
      subject.enemies << create(:dog)
      subject.enemies << create(:dog)
    end

    it 'doesnt save unchanged records' do
      ccount = 0
      dcount = 0
      allow_any_instance_of(Cat).to receive(:publish_save_successful) { ccount += 1 }
      allow_any_instance_of(Dog).to receive(:publish_save_successful) { dcount += 1 }
      Cat.find(subject.id).update(answers_to: 'Pickles')
      expect(ccount).to eq(1)
      expect(dcount).to eq(0)
    end
  end

  describe 'with monitored_dogs' do
    before do
      subject.monitored_dogs << create(:dog)
      subject.monitored_dogs << create(:dog)
    end

    it 'doesnt save unchanged records' do
      ccount = 0
      dcount = 0
      allow_any_instance_of(Cat).to receive(:publish_save_successful) { ccount += 1 }
      allow_any_instance_of(Dog).to receive(:publish_save_successful) { dcount += 1 }
      Cat.find(subject.id).update(answers_to: 'Pickles')
      expect(ccount).to eq(1)
      expect(dcount).to eq(0)
    end
  end

  def expect_save_callbacks(times = 1)
    count = 0
    allow_any_instance_of(Cat).to receive(:publish_save_successful) { count += 1 }
    yield
    expect(count).to eq(times)
  end
end
