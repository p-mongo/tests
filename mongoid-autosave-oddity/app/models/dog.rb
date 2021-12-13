class Dog
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name

  has_and_belongs_to_many :enemies, class_name: 'Cat'

  belongs_to :watched_by, class_name: 'Cat', optional: true

  after_save :publish_save_successful

  def publish_save_successful
    true
  end
end
