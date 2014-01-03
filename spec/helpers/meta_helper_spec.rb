require "spec_helper"

describe MetaHelper do
  describe "meta_builder" do
    it "accepts block and formats string" do
      helper.meta_builder(:title, "Latest") { "Latest " + META['title'] }.should eq "Latest #{META['title']}"
    end
  end
  
  describe "meta_title" do
    it "with no params returns META" do
      helper.meta_title.should eq META["title"]
    end
    
    it "with valid params returns string" do
      helper.meta_title("Latest").should eq "Latest | #{META["title"]}"
    end
  end
  
  describe "meta_keywords" do
    it "with no params returns META" do
      helper.meta_keywords.should eq META["keywords"]
    end
    
    it "with valid params returns string" do
      helper.meta_keywords("golf").should eq "golf, #{META["keywords"]}"
    end
  end
  
  describe "meta_description" do
    it "with no params returns META description" do
      helper.meta_description.should eq META["description"]
    end
    
    it "with valid params returns string" do
      helper.meta_description("This is how we do it").should eq "This is how we do it. #{META['description']}"
    end
  end
end