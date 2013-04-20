task :delete_screenshots do
  FileUtils.rm Dir.glob("#{Rails.root}/public/uploads/tmp/screenshots/*")
end