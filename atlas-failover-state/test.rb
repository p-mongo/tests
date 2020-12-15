require 'mongo_cloud'
require 'byebug'

client = MongoCloud::Client.new(
  user: ENV.fetch('ATLAS_API_USERNAME'),
  password: ENV.fetch('ATLAS_API_PASSWORD'),
)

project = client.get_project_by_name('oleg-test')
clusters = client.list_clusters(project_id: project['id'])

cluster = client.get_cluster(project_id: project['id'], name: '59d5074fc6')
unless cluster['state_name'] == 'IDLE'
  raise "Cannot failover: cluster state #{cluster['state_name']}"
end

client.failover_cluster(project_id: project['id'], name: cluster['name'])

loop do
  cluster = client.get_cluster(project_id: project['id'], name: '59d5074fc6')
  puts "#{Time.now.strftime('%H:%M:%S.%6N')}: #{cluster['state_name']}"
  unless cluster['state_name'] == 'IDLE'
    break
  end
end
