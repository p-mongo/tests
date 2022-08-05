class Manager
  include Mongoid::Document

  belongs_to :band, optional: true
end
