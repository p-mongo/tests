require 'awesome_print'
require 'mongo_cloud'
autoload :Byebug, 'byebug'

client = MongoCloud::Client.new

counter = 0
loop do
  projects = client.list_projects
  project = projects.first
  clusters = client.list_clusters(project_id: project['id'])
  print '.'
  counter += 1
  if counter % 100 == 0
    puts "\n#{counter}"
  end
end
