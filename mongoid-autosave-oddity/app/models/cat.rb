class Cat
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :answers_to, type: String

  has_and_belongs_to_many :dogs
  has_many :minions, class_name: 'Cat', inverse_of: :leader
  accepts_nested_attributes_for :minions

  belongs_to :leader, class_name: 'Cat', optional: true

  after_save :publish_save_successful

  def publish_save_successful
    true
  end
end
