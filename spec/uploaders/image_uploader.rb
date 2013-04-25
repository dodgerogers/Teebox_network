require 'spec_helper'
require 'carrierwave/test/matchers'

describe ImageUploader do
  include CarrierWave::Test::Matchers 
  
  before do
    VideoUploader.enable.processing = true
    @user = FactoryGirl.create(:user)
    @uploader = VideoUploader.new(@user, FactoryGirl.create(:video))
    @uploader.store!(File.open("#{Rails.root}/spec/test_files/edited_driver_swing.m4v"))
  end
  
  after do 
    @uploader.remove!
  end
  
  context "taking a screenshot" do
    it "should take a screenshot of 270 x 135 pixels" do
      @uploader.screenshot.should_have_dimensions(270, 135)
    end
  end
end