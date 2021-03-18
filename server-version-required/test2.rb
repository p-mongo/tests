require 'mongo'
require 'byebug'

def test(port)
  client = Mongo::Client.new(["localhost:#{port}"], server_api: {version: 1})

  client.use('test')['test'].delete_many
  p client.use('test')['test'].count

  client.cluster.next_primary.with_connection do |conn|
    insert = Mongo::Protocol::Insert.new('test', 'test', [{'name' => 'testing'}])

    p conn.dispatch([insert])

    query = Mongo::Protocol::Query.new('test', '$cmd', {getLastError: 1}, limit: 1)

    p conn.dispatch([query])

    query = Mongo::Protocol::Query.new('test', 'test', { 'name' => 'testing' })

    p conn.dispatch([query])
  end

  p client.use('test')['test'].count
  p client.use('test')['test'].find.first
end

[14900, 14920, 14940].each do |port|
  puts
  puts "Testing #{port}"
  test(port)
end
