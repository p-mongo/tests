task :test_4868_1 => :environment do

class Contract

   include Mongoid::Document



   embeds_many :special_conditions, :class_name => 'Condition'

end





class Condition

  include Mongoid::Document



  embedded_in :contract



  field :name, :type => String

end



contract = Contract.new

contract.special_conditions = []

contract.save!

p contract.collection.find(_id: contract.id).first

# => {"_id"=>BSON::ObjectId('5e8bd0d8e1b8321958afa605')}


contract.special_conditions = [Condition.new]

contract.save!

p contract.collection.find(_id: contract.id).first

# => {"_id"=>BSON::ObjectId('5e8bd105e1b8321982e6f1fe'), "special_conditions"=>[{"_id"=>BSON::ObjectId('5e8bd105e1b8321982e6f1ff')}]}


contract.special_conditions = []

contract.save!

p contract.collection.find(_id: contract.id).first

# => {"_id"=>BSON::ObjectId('5e8bd105e1b8321982e6f1fe'), "special_conditions"=>[]}


end
