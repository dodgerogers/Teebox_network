task :delete_tmp_files do
  FileUtils.rm Dir.glob("#{Rails.root}/public/uploads/tmp/screenshots/*")
end

task :carrierwave_tmp do 
  CarrierWave.clean_cached_files!
end
