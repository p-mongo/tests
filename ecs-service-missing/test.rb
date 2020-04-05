require 'aws-sdk-ecs'

cluster_name = ENV.fetch('IAM_AUTH_ECS_CLUSTER')

client = Aws::ECS::Client.new(
  region: 'us-east-1',
  credentials: Aws::Credentials.new(
    ENV.fetch('IAM_AUTH_ECS_ACCOUNT'),
    ENV.fetch('IAM_AUTH_ECS_SECRET_ACCESS_KEY'),
  ),
)

stop = false
prefix = Time.now.to_i
1.upto(100) do |i|
  service_name = "test_service_#{prefix}_#{i}"

  service = client.create_service(
    desired_count: 1,
    service_name: service_name,
    task_definition: ENV.fetch('IAM_AUTH_ECS_TASK_DEFINITION'),
    cluster: cluster_name,
    launch_type: 'FARGATE',
    network_configuration: {
      awsvpc_configuration: {
        subnets: [ENV.fetch('IAM_AUTH_ECS_SUBNET_A')],
        security_groups: [ENV.fetch('IAM_AUTH_ECS_SECURITY_GROUP')],
      },
    },
  ).service

  p service

  client.wait_until(
    :services_stable, {
      cluster: cluster_name,
      services: [service_name],
    },
    delay: 5,
    max_attempts: 10,
  )

  service = client.describe_services(
    cluster: cluster_name,
    services: [service_name],
  ).services.first

  if service
    puts "Round #{i}: got a service for #{service.service_name}"
  else
    puts "Round #{i}: did not get a service for #{service.service_name}"
    stop = true
  end

  client.update_service(
    cluster: cluster_name,
    service: service.service_name,
    desired_count: 0,
  )
  client.delete_service(
    cluster: cluster_name,
    service: service.service_name,
  )

  break if stop
end
