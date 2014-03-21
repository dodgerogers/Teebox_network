set :output, "#{path}/log/cron.log"

every :day, at: "01:00am" do
  rake "db:social_statistics"
end

every :day, at: "02:00am" do
  rake "delete_tmp_files"
end

every :day, at: "03:00am" do
  rake "user:rank"
end

every :day, at: "8:00am" do
  rake "db:generate_report"
end

every 3.hours do
  rake "carrierwave_tmp"
end

# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
