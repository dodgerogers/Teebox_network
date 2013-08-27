require "spec_helper"

describe Tag do
  before(:each) do
    @tag = FactoryGirl.create(:tag)
  end
  
  subject { @tag }
  
  it { should respond_to(:name) }
  it { should respond_to(:explanation) }
  it { should respond_to(:updated_by) }
  it { should have_many(:taggings)}
  it { should have_many(:questions).through(:taggings)}
  it { should validate_presence_of(:name)}
  it { should ensure_length_of(:name).is_at_least(2) }
  it { should validate_uniqueness_of(:name)}
  
  describe 'name' do
     before { @tag.name = nil }
     it { should_not be_valid }
   end
   
   describe "obscenity filter name" do
     before { @tag.name = "shit" }
     it { should_not be_profane }
   end
   
   describe "validates explanation" do
     before { @tag.explanation = "fuck" }
     it { should_not be_profane }
   end
end