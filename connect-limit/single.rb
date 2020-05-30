require 'mongo'

Mongo::Logger.logger.level = Logger::INFO

client = Mongo::Client.new(['localhost:34420'],
  min_pool_size: 20_000, max_pool_size: 100_000, connect: :direct)

servers = client.cluster.servers.sort_by { |s| s.address.seed }

def open_fds
  Dir["/proc/#{Process.pid}/fd/*"].count
end

loop do
  puts(servers.map do |s|
    "#{s.address.seed}: #{'%-5d' % s.pool.size} open sockets: #{$open} open fds: #{open_fds}"
  end.join(' '))
  sleep 1
end
