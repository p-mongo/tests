require 'mongo'

clients = {}

ports = %w(14441 14442 14443 14444 14445 14446)

ports.each do |port|
  client = Mongo::Client.new(["localhost:#{port}"], connect: :direct, database: 'admin')
  clients[port] = client
end

loop do
  ports.each do |port|
    client = clients[port]
    res = client.command(serverStatus: 1).documents.first
    STDOUT << "#{port}: #{client.cluster.servers.first.status}, #{res['metrics']['commands']['find']['total']}"
    STDOUT << " / #{res['opcounters']['query']}   "
  end
  STDOUT.puts
  sleep 2
end
