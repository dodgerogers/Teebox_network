# This file is used by Rack-based servers to start the application.

# -- Unicorn Killer code

	# Unicorn self-process killer
  require 'unicorn/worker_killer'

  # Max requests per worker
  use Unicorn::WorkerKiller::MaxRequests, 50, 100

  # Max memory size (RSS) per worker
  use Unicorn::WorkerKiller::Oom, (40 * (1024**2)), (60 * (1024**2))

# -- End Unicorn Killer

require ::File.expand_path('../config/environment',  __FILE__)
run TeeboxNetwork::Application
