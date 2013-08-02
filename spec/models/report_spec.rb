require "spec_helper"

describe Report do
  before(:each) do
    @report = create(:report)
  end
  
  subject { @report }
  it { should respond_to(:questions) }
  it { should respond_to(:questions_average) }
  it { should respond_to(:answers) }
  it { should respond_to(:answers_average) }
  it { should respond_to(:users) }
  it { should respond_to(:users_average) }
end
