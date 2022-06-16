task 'test:4674' => :environment do

class Manufactory
  include Mongoid::Document

  embeds_many :products, order: :id.desc # here
end

class Product
  include Mongoid::Document

  embedded_in :manufactory

  field :name, type: String
end


manufactory = Manufactory.create!

p Product.create!(manufactory:manufactory,name:'car')

p manufactory.products

manufactory.products.destroy_all

p manufactory.products

manufactory.reload

p manufactory.products

end
