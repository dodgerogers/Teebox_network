root = "/home/andrew/rails/teebox/current"
working_directory root
pid "#{root}/tmp/pids/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

listen "/tmp/unicorn.teebox.sock"
worker_processes 2
#preload_app true
timeout 30

# before_fork do |server, worker|
#   ActiveRecord::Base.connection.disconnect! if defined? ActiveRecord::Base
# end
# 
# after_fork do |server, worker|
#   ActiveRecord::Base.establish_connection if defined? ActiveRecord::Base
# end