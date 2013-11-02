require "#{Rails.root}/app/models/report"

task generate_report: :environment do
  Report.create
end

task rm_test_users: :environment do
  User.where(role: "tester").destroy_all
end

task rm_tags: :environment do
  Tag.destroy_all
end

task rank_users: :environment do
   results = {}
   	User.order("reputation desc").each { |user| results[user.reputation] = User.where(reputation: user.reputation).map(&:id) }
   	results.each_with_index { |user, rank| user[1].each {|u| User.find_by_id(u).update_attributes(rank: rank + 1) } }
end

task :delete_tmp_files do
  FileUtils.rm_rf Dir.glob("#{Rails.root}/public/uploads/tmp/screenshots/*")
end

task :carrierwave_tmp do 
  CarrierWave.clean_cached_files!
end

task :delete_capybara do
  FileUtils.rm_rf Dir.glob("#{Rails.root}/tmp/capybara/*")
end

task :delete_dev_logs do
  FileUtils.rm "#{Rails.root}/log/development.log"
end

task :delete_test_logs do
  FileUtils.rm "#{Rails.root}/log/test.log"
end
