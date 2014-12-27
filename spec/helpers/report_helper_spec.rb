require 'spec_helper'

describe ReportHelper do
  before(:each) do
    2.times { create(:report) }
  end
  
  describe 'display_percentage_stats' do
    context 'renders html' do
      it 'does something' do
        html = helper.display_percentage_stats(Report.order("created_at"))
        
        html.should have_selector('section')
        html.should include('Questions')
        html.should include('Answers')
        html.should include('Users')
      end
    end
  end
  
  describe "percent_of" do
    it "calculates correct % decrease with positive numbers" do
      helper.percent_of(3, 10).should eq(-70.0)
    end
    
    it "calculates correct % increase with positive numbers" do
      helper.percent_of(10, 3).should eq(233.33)
    end
    
    it "returns 0 when any values are 0" do
      helper.percent_of(2, 0).should eq(0.0)
      helper.percent_of(0, 1).should eq(0.0)
    end
  end
end