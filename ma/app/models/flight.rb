class Flight
  include Mongoid::Document

  embeds_one :plan
end
