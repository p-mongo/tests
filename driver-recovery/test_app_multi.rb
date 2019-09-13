require_relative './test_app'
autoload :Typhoeus, 'typhoeus'

class MultiAppTester < AppTester

  def do_run_loop_iteration
    target_time = Time.now + 1
    hydra = Typhoeus::Hydra.new
    options[:target_ops].times do
      req = Typhoeus::Request.new(server_base_url)
      hydra.queue(req)
    end
    hydra.run
    delta = target_time - Time.now
    if delta > 0
      sleep(delta)
    end
  end
end
