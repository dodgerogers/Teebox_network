require 'spec_helper'

describe Video do
  before(:each) do
    @video = FactoryGirl.create(:video)
  end
  
  subject { @video }
  
  it { should respond_to(:user_id) }
  it { should respond_to(:file) }
  it { should respond_to(:screenshot) }
  it { should respond_to(:question_id) }
  it { should have_many(:questions) }
  it { should belong_to(:user) }
  
  describe 'file' do
     before { @video.file = nil }
     it { should_not be_valid }
   end
   
  describe "user_id" do
    before { @video.user_id = nil }
      it { should_not be_valid }
    end
    
  describe "get_key" do
    it "extracts the key" do
      subject.get_key("http://teebox-network.s3.amazonaws.com/uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v").should eq "uploads/video/file/22120817-19bf-40ec-96f1-3c904772370b/3-wood-creamed.m4v"  
    end 
  end
  
  describe "unique" do
    it "renders random string" do
     Video.stub!(:rand).and_return(1)
     subject.unique.should be_a_kind_of(String)
    end
  end
end