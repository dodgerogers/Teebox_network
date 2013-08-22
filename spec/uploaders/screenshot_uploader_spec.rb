require 'spec_helper'
require 'carrierwave/test/matchers'
require "pathname"

describe ScreenshotUploader do
  include CarrierWave::Test::Matchers 
  
  before do
    @user = create(:user)
    @uploader = ScreenshotUploader.new(@user, create(:video))
    #@uploader.store!(File.open("#{Rails.root}/spec/fixtures/NGICJSJ_edited_driver_swing.m4v.jpg"))
  end
  
  after do 
    @uploader.remove!
  end
  
  context "taking a screenshot" do
    it "should take a screenshot of 270 x 135 pixels" do
      #@uploader.mini.should_have_dimensions(200, 100)
    end
  end
  
  describe "cache_dir" do
    it "sets dir" do
      @uploader.cache_dir.should eq(Pathname.new("/Users/andrew/rails/teebox_network/public/uploads"))
    end
  end
  
  describe "extensions" do
    it "correct whitelist" do
      @uploader.extension_white_list.should eq(%w(jpg jpeg png))
      end
    end
    
  describe "store_dir" do
    it "renders path to uploads" do
      #@uploader.store_dir.should eq("uploads/user/#{@uploader}/")
    end
  end  
  
  describe "delete_tmp_dir" do
    it "delete_tmp_dir if upload successful" do
      file = File.open("#{Rails.root}/spec/fixtures/files/seven_iron.jpeg")
      @uploader.delete_tmp_dir(file).should eq(nil)
    end
  end
end