require "spec_helper"

describe ReportRepository do
  before(:each) do
    @report = create(:report)
  end
  
  describe "errors" do
    it "raises Argument Error when not supplied a report object" do
      expect { 
        ReportRepository.generate("string argument") 
        }.to raise_error(ArgumentError, "ReportRepository error: must supply a valid report object")
    end
  end
end