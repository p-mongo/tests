require_relative './base'

class DeploymentMonitor < Base
  def log_path
    'monitor.log'
  end

  def default_client_options
    {heartbeat_interval: 1}
  end

  def run
    loop do
      puts client.cluster.summary
      sleep 1
    end
  end
end
