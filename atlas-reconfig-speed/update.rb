require 'mongo_cloud'
require 'byebug'

client = MongoCloud::Client.new(
  user: ENV.fetch('ATLAS_API_USERNAME'),
  password: ENV.fetch('ATLAS_API_PASSWORD'),
)

project = client.get_project_by_name('oleg-test-1')
cluster = client.list_clusters(project_id: project['id']).first
name = cluster['name']

p "Using cluster #{name}"

info = client.update_cluster(project_id: project['id'],
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

puts "Took #{elapsed.to_i} seconds to update the cluster"
