require 'mongo_cloud'
require 'byebug'

client = MongoCloud::Client.new(
  user: ENV.fetch('ATLAS_API_USERNAME'),
  password: ENV.fetch('ATLAS_API_PASSWORD'),
)

project = client.get_project_by_name('oleg-test-1')
clusters = client.list_clusters(project_id: project['id'])
clusters.each do |cluster|
  client.delete_cluster(project_id: project['id'], name: cluster['name'])
end

name = "oleg-test-#{(rand * 1000).to_i}"

info = client.create_cluster(project_id: project['id'],
  name: name,
  providerSettings: {
    providerName: 'AWS',
    regionName: 'US_WEST_1',
    instanceSizeName: 'M10',
  },
)

start = Time.now

loop do
  t = client.get_cluster(project_id: project['id'], name: name)
  puts "#{Time.now} #{t['stateName']}"
  if t['stateName'] == 'IDLE'
    break
  else
    sleep 1
  end
end

elapsed = Time.now - start

puts "Took #{elapsed.to_i} seconds to create the cluster"
