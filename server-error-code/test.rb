require 'mongo'
require 'byebug'

def test(port)
  client = Mongo::Client.new(["localhost:#{port}"], database: 'test')

  coll = client['foo']
  coll.delete_many

  coll.insert_one(_id: 1)
  begin
    coll.insert_one(_id: 1)
  rescue Mongo::Error::OperationFailure => e
    pp e.document
  end
end

[14400, 14420, 14440, 14900, 14920, 14940].each do |port|
  puts
  puts "Testing #{port}"
  test(port)
end
