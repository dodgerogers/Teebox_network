require "spec_helper"

describe Tag do
  before(:each) do
    @tag = FactoryGirl.create(:tag)
  end
  
  subject { @tag }
  
  it { should respond_to(:name) }
  it { should respond_to(:explanation) }
  it { should respond_to(:updated_by) }
  
  describe 'name' do
     before { @tag.name = nil }
     it { should_not be_valid }
   end
end