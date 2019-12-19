require 'mongo'

Mongo::Logger.logger.level = :warn

client = Mongo::Client.new(['127.0.0.1:14420'])

collection = client['foo']
collection.delete_many

p collection.find.count # => 0

p collection.find(_id: BSON::ObjectId('5dfa8ad7ea64ae457941102b')).update_one({'$set' => {foo: 'bar'}}, upsert: true) # =>

#<Mongo::Operation::Update::Legacy::Result:0x70339487480360 documents=[]>

p collection.find.count # => 0


=begin

0
#<Mongo::Operation::Update::Result:0x47043191828320 documents=[{"n"=>1, "nModified"=>0, "upserted"=>[{"index"=>0, "_id"=>BSON::ObjectId('5dfa8ad7ea64ae457941102b')}], "opTime"=>{"ts"=>#<BSON::Timestamp:0x000055923179ef50 @seconds=1576794056, @increment=2>, "t"=>1}, "electionId"=>BSON::ObjectId('7fffffff0000000000000001'), "ok"=>1.0, "$clusterTime"=>{"clusterTime"=>#<BSON::Timestamp:0x000055923179edc0 @seconds=1576794056, @increment=2>, "signature"=>{"hash"=><BSON::Binary:0x47043191830100 type=generic data=0x0000000000000000...>, "keyId"=>0}}, "operationTime"=>#<BSON::Timestamp:0x000055923179ec08 @seconds=1576794056, @increment=2>}]>
1

=end
