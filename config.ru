# This file is used by Rack-based servers to start the application.

# -- Unicorn Killer code

if ENV['RAILS_ENV'] == 'production'
	require 'unicorn/worker_killer'

	max_request_min = 400
	max_request_max = 500
	
	use Unicorn::WorkerKiller::MaxRequests, max_request_min, max_request_max
	
	oom_min = (210) * (1024**2)
	oom_max = (230) * (1024**2)
	
	# Max memory per worker
	use Unicorn::WorkerKiller::Oom, oom_min, oom_max
end

# -- End Unicorn Killer

require ::File.expand_path('../config/environment',  __FILE__)
run TeeboxNetwork::Application
