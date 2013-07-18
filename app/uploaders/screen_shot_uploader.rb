# encoding: utf-8
require 'carrierwave/processing/rmagick'

class ScreenShotUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper

  #storage :fog set in intializer
  
  before :store, :remember_cache_id
  after :store, :delete_tmp_dir
  
  version :mini do
    process resize_and_pad: [200, 150, '#fff']
  end
  
  def cache_dir
    Rails.root.join('public/uploads/tmp/screenshots') 
  end
    
  def remember_cache_id(new_file)
    @cache_id_was = cache_id
  end

  def delete_tmp_dir(new_file)
    # make sure we don't delete other things accidentally by checking the name pattern
    if @cache_id_was.present? && @cache_id_was =~ /\A[\d]{8}\-[\d]{4}\-[\d]+\-[\d]{4}\z/
      FileUtils.rm_rf(File.join(root, cache_dir, @cache_id_was))
    end
  end
  
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  def extension_white_list
    %w(jpg png)
    # %w(ogg ogv 3gp mp4 m4v webm mov)
  end
end
