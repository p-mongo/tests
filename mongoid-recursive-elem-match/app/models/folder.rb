class Folder
  include Mongoid::Document

  field :name, type: String
  field :permissions, type: String

  recursively_embeds_many

end
