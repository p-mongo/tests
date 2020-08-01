workers 2
preload_app!

# Comment out the rest of this file to see NoServerAvailable error.

before_fork do
  p 'before fork'
  Mongoid.disconnect_clients
end

on_worker_boot do
  p 'worker boot'
  Mongoid::Clients.clients.each do |name, client|
    client.close
    client.reconnect
  end
end
