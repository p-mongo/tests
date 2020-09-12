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
byebug
1
