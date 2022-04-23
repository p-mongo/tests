task :test_5306 => :environment do

class Company
  include Mongoid::Document

  has_many :users
  has_many :shops
end

class Shop
  include Mongoid::Document

  embeds_one :address
  belongs_to :company

  after_initialize :build_address1

  def build_address1
    self.address ||= Address.new
  end
end

class Address
  include Mongoid::Document
  embedded_in :shop
end

class User
  include Mongoid::Document

  belongs_to :company

  validate :break_mongoid

  def break_mongoid
    company.shop_ids
  end
end



company = Company.create!

shop = Shop.create!(company: company)

user = User.new
user.company = company
user.save!


end
