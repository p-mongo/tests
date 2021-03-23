require 'mongo'

clients = {}

ports = %w(14041 14042 14043 14044 14045 14046)

ports.each do |port|
  client = Mongo::Client.new(["localhost:#{port}"], connect: :direct)
  clients[port] = client
end

loop do
  ports.each do |port|
    client = clients[port]
    res = client.command(serverStatus: 1).documents.first
    STDOUT << "#{port}: #{client.cluster.servers.first.status}, #{res['metrics']['commands']['find']['total']}   "
  end
  STDOUT.puts
  sleep 2
end
