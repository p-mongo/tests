class Person
  include Mongoid::Document
  field :ssn

  index({ ssn: 1 }, { unique: true, name: "ssn_index" })

  embeds_many :addresses
  index "addresses.street" => 1

  field :first_name
  field :last_name

  index({ first_name: 1, last_name: 1 }, { unique: true })

  index({ ssn: -1 }, { sparse: true })

  index({ ssn: 1 }, { unique: true, background: true })

  index({ ssn: 1 }, { unique: true, drop_dups: true })

  field :location, type: Array

  index({ location: "2d" }, { min: -200, max: 200 })

  index({ ssn: 1 }, { database: "users", unique: true, background: true })

  belongs_to :post, index: true
  has_and_belongs_to_many :preferences, index: true
end
