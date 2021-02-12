#require 'async/dns'
require 'mongo'
require 'awesome_print'
require 'mongo_cloud'
autoload :Byebug, 'byebug'

client = MongoCloud::Client.new

projects = client.list_projects
project = projects.first
clusters = client.list_clusters(project_id: project['id'])
cluster_name = ARGV.shift
if cluster_name
  cluster = clusters.detect { |c| c['name'] == cluster_name }
else
  raise 'Need cluster name'
end
if cluster.nil?
  raise 'Could not find'
end

ap cluster

requests = 0
puts
loop do
  info = client.get_cluster(project_id: project['id'], name: cluster['name'])
  uri = Mongo::URI.get(info['connection_strings']['standard_srv'])
  if uri.servers.empty?
    raise 'Uh oh'
  end
=begin
  Async::Reactor.run do
    resolver = Async::DNS::Resolver.new([])
    #resolver.addresses_for(server)
    Byebug.byebug
  end
=end
  Resolv::DNS.open(nameserver: '127.0.0.1', nameserver_port: [['127.0.0.1', 53]]) do |dns|
  #Byebug.byebug
    uri.servers.each do |server|
      host = server.sub(/:.*/, '')
      ress = dns.getresources host, Resolv::DNS::Resource::IN::A
      if ress.empty?
        raise 'Uh oh here'
      end
    end
  end
  print("\r#{'%4d' % requests} #{info['name']} #{info['state_name']}       ")
  requests += 1
end
puts
