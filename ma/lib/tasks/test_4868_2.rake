# Same as test_4868_1 but without the class name override

task :test_4868_2 => :environment do

class Contract

   include Mongoid::Document



   embeds_many :conditions

end





class Condition

  include Mongoid::Document



  embedded_in :contract



  field :name, :type => String

end



contract = Contract.new

contract.conditions = []

contract.save!

p contract.collection.find(_id: contract.id).first

# => {"_id"=>BSON::ObjectId('5e8bd0d8e1b8321958afa605')}


contract.conditions = [Condition.new]

contract.save!

p contract.collection.find(_id: contract.id).first

# => {"_id"=>BSON::ObjectId('5e8bd105e1b8321982e6f1fe'), "conditions"=>[{"_id"=>BSON::ObjectId('5e8bd105e1b8321982e6f1ff')}]}


contract.conditions = []

contract.save!

p contract.collection.find(_id: contract.id).first

# => {"_id"=>BSON::ObjectId('5e8bd105e1b8321982e6f1fe'), "conditions"=>[]}



contract = Contract.new

contract.conditions = [Condition.new]
contract.conditions = []

contract.save!

p contract.collection.find(_id: contract.id).first

# => {"_id"=>BSON::ObjectId('5e8bd202e1b83219f9582225')}



contract = Contract.find(contract.id)
p contract.conditions

end
