require 'spec_helper'
require 'carrierwave/test/matchers'

describe ScreenShotUploader do
  include CarrierWave::Test::Matchers 
  
  before do
    @user = create(:user)
    @uploader = ScreenShotUploader.new(@user, create(:video))
    @uploader.store!(File.open("#{Rails.root}/spec/fixtures/NGICJSJ_edited_driver_swing.m4v.jpg"))
  end
  
  after do 
    @uploader.remove!
  end
  
  context "taking a screenshot" do
    it "should take a screenshot of 270 x 135 pixels" do
      #@uploader.mini.should_have_dimensions(200, 100)
    end
  end
end