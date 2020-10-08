require 'mongo'

Mongo::Logger.logger.level = Logger::INFO

client = Mongo::Client.new(['localhost:34420'],
  min_pool_size: 20_000, max_pool_size: 100_000)

servers = client.cluster.servers.sort_by { |s| s.address.seed }

loop do
  puts(servers.map do |s|
    "#{s.address.seed}: #{'%-5d' % s.pool.size}"
  end.join(' '))
  STDOUT.flush
  sleep 1
end
