task :carrierwave_tmp do 
  CarrierWave.clean_cached_files!
end