#require 'async/dns'
require 'mongo'
require 'awesome_print'
require 'mongo_cloud'
autoload :Byebug, 'byebug'

10_000.times do |i|
  Resolv::DNS.open(nameserver: '127.0.0.1', nameserver_port: [['127.0.0.1', 53]]) do |dns|
      ress = dns.getresources 'cloud-dev.mongodb.com', Resolv::DNS::Resource::IN::A
      if ress.empty?
        raise 'Uh oh here'
      end
  end
  print('.')
  if i > 0 && i % 100 == 0
    puts "\n#{i}"
  end
end
puts
