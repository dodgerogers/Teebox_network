namespace :db do
  task generate_report: :environment do
    report = Report.new
    totals = ReportRepository.generate(report)
  end

  task rm_tags: :environment do
    Tag.destroy_all
  end
  
  task social_statistics: :environment do
    social = Statistics::Social.new
    social.generate
    social.save!
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

task :delete_capybara do
  FileUtils.rm_rf Dir.glob("#{Rails.root}/tmp/capybara/*")
end
