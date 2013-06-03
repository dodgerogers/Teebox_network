require "spec_helper"

describe Tick do
  before(:each) do
    @tick = FactoryGirl.create(:tick)
  end
  
  subject { @tick }
  
  it { should respond_to(:user_id) }
  it { should respond_to(:answer_id) }
  it { should respond_to(:correct) }
  
   describe 'answer_id' do
     before { @tick.answer_id = nil }
     it { should_not be_valid }
   end
   
   describe "user_id" do
     before { @tick.user_id = nil }
      it { should_not be_valid }
    end
  end