class Cat
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :answers_to, type: String

  # Mutual disliking
  has_and_belongs_to_many :enemies, class_name: 'Dog'
  accepts_nested_attributes_for :enemies

  # One way distrust
  has_many :monitored_dogs, class_name: 'Dog', inverse_of: :watched_by
  accepts_nested_attributes_for :monitored_dogs

  # All my people
  has_many :minions, class_name: 'Cat', inverse_of: :leader
  accepts_nested_attributes_for :minions

  # Ma fam
  has_and_belongs_to_many :buddies, class_name: 'Cat', inverse_of: :leader
  accepts_nested_attributes_for :buddies

  # Oh glorious leader
  belongs_to :leader, class_name: 'Cat', optional: true
  accepts_nested_attributes_for :leader

  after_save :publish_save_successful

  def publish_save_successful
    true
  end
end
