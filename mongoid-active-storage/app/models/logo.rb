class Logo
  include Mongoid::Document
  include Mongoid::Timestamps

  has_one_attached :image
end
