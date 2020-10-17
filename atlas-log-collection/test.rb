require 'mongo_cloud'

client = MongoCloud::Client.new(
  user: ENV.fetch('ATLAS_API_USERNAME'),
  password: ENV.fetch('ATLAS_API_PASSWORD'),
)

aclient = MongoCloud::Client.new(
  user: ENV.fetch('ATLAS_ADMIN_API_USERNAME'),
  password: ENV.fetch('ATLAS_ADMIN_API_PASSWORD'),
)

project = client.list_projects.first
cluster = client.list_clusters(project_id: project['id']).first

20.times do
  id = aclient.create_log_collection_job(project_id: project['id'],
    cluster_name: cluster['name'], log_types: %w(ftdc))
  p id
  p aclient.get_log_collection_job(project_id: project['id'], id: id)
end
