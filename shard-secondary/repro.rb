require 'mongo'

$clients = {}

#$ports = %w(14441 14442 14443 14444 14445 14446)
$ports = %w(14941 14942 14943 14944 14945 14946)
$test_port = 14940

$ports.each do |port|
  client = Mongo::Client.new(["localhost:#{port}"], connect: :direct, database: 'admin')
  $clients[port] = client
end

def report
  $ports.each do |port|
    client = $clients[port]
    res = client.command(serverStatus: 1).documents.first
    STDOUT << "#{port}: #{client.cluster.servers.first.status}, #{res['metrics']['commands']['find']['total']}"
    STDOUT << " / #{res['opcounters']['query']}   "
  end
  STDOUT.puts
end

def test(db)
  puts "Testing database #{db}"

  report

  Mongo::Client.new(["localhost:#{$test_port}"], database: db) do |client|
    client['foo'].insert_one(a: 1)
    read_client = client.with(read: {mode: :primary})
    100.times do
      read_client['foo'].find.first
    end
  end

  report

  puts
end

test('foo')
test('admin')
test('config')
test('bar')
