require 'rails_helper'

describe Cat do
  subject! { create(:cat) }

  it 'does' do
    expect_save_callbacks(1) do
      Cat.find(subject.id).update(answers_to: 'Pickles')
    end
  end

  #
  # toggling on / off # accepts_nested_attributes_for :specific_appraisees in User
  # is the proof of this oddity
  #
  describe 'with specific_appraisees' do
    before do
      subject.minions << create(:cat)
      subject.minions << create(:cat)
    end

    it 'does' do
      expect_save_callbacks(1) do
        Cat.find(subject.id).update(answers_to: 'Pickles')
      end
    end
  end

  def expect_save_callbacks(times = 1)
    count = 0
    allow_any_instance_of(Cat).to receive(:publish_save_successful) { count += 1 }
    yield
    expect(count).to eq(times)
  end
end
