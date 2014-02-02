# This file is used by Rack-based servers to start the application.

if ENV["RAILS_ENV"] == "production"
  # GC_FREQUENCY = 20
  #   require "unicorn/oob_gc"
  #   GC.disable
  #   use Unicorn::OobGC, GC_FREQUENCY
  
  require "unicorn_killer"
  use UnicornKiller::MaxRequests, 500
  use UnicornKiller::Oom, 70 * 1024
end

require ::File.expand_path('../config/environment',  __FILE__)
run TeeboxNetwork::Application
