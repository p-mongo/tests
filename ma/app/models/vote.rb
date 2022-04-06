class Vote
  include Mongoid::Document

  field :message, type: String
  field :metadata, type: Hash
end
