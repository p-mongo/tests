class Email
  include Mongoid::Document

  belongs_to :company
end
