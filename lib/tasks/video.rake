task :delete_tmp_files do
  FileUtils.rm Dir.glob("#{Rails.root}/public/uploads/tmp/screenshots/*")
end

task :carrierwave_tmp do 
  CarrierWave.clean_cached_files!
end

task :delete_capybara do
  FileUtils.rm Dir.glob("#{Rails.root}/tmp/capybara/*")
end

task :delete_dev_logs do
  FileUtils.rm "#{Rails.root}/log/development.log"
end

task :delete_test_logs do
  FileUtils.rm "#{Rails.root}/log/test.log"
end

task :generate_report => :environment do
  Report.create
end
