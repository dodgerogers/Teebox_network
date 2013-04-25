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
end