task :test_4734 => :environment do


# app/models/address.rb
class Address
  include Mongoid::Document

  field :city, type: String

  embedded_in :addressable, polymorphic: true
end

# app/models/company.rb
class Company
  include Mongoid::Document

  embeds_one :address, class_name: 'Address', as: :addressable
  accepts_nested_attributes_for :address

  embeds_one :delivery_address, class_name: 'Address', as: :addressable
  accepts_nested_attributes_for :delivery_address
end

acme = Company.create(address: { city: 'Gotham' }, delivery_address: { city: 'Parcelville' })


acme.update(delivery_address: Address.new(city: 'Bigville'))
# => true
p acme.reload.address.city
# => "Bigville" # <-- delivery_address should have been updated, not address
p acme.reload.delivery_address.city
# => "Smallville" # <-- delivery_address unchanged despite call to #update


end
