require 'mongo'
require 'mongo_cloud'
require 'byebug'

client = MongoCloud::Client.new(
  user: ENV.fetch('ATLAS_API_USERNAME'),
  password: ENV.fetch('ATLAS_API_PASSWORD'),
)

project = client.get_project_by_name('oleg-test-1')
info = client.list_clusters(project_id: project['id']).first

begin
  client.create_db_user(project_id: project['id'],
    #databaseName: 'admin',
    #roles: [roleName: 'atlasAdmin'],
    username: 'foo',
    password: 'foo',
  )
rescue MongoCloud::Client::ApiError => exc
  if exc.error_code == 'USER_ALREADY_EXISTS'
    # Ignore
  else
    raise
  end
end

client = Mongo::Client.new(info['connectionStrings']['standardSrv'], database: 'foo',
  user: 'foo', password: 'foo')
100.times do |i|
  client['foo'].insert_one(test: i)
end
