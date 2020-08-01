preload_app true

# Comment out the rest of this file to see NoServerAvailable error.

before_fork do |_, _|
  p 'before fork'
  Mongoid.disconnect_clients
end

after_fork do |server, worker|
  p 'after fork'
  Mongoid::Clients.clients.each do |name, client|
    client.close
    client.reconnect
  end
end
