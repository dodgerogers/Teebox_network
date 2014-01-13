namespace :db do
  task generate_report: :environment do
    report = Report.new
    totals = GenerateReport.new(report)
    totals.create
    report.save!
  end

  task rm_tags: :environment do
    Tag.destroy_all
  end
end

namespace :user do
  task rm_test: :environment do
    User.where(role: "tester").destroy_all
  end
  
  task rank: :environment do
    User.rank_users
  end
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
