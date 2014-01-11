require "spec_helper"

describe TagHelper do
  describe "tag_class" do
    it "returns tag as class" do
      tag = create(:tag)
      helper.tag_class(tag).should eq("tag")
    end
  end
  
  describe "tab_class" do
    it "returns asphalt as class" do
      tag = create(:tag)
      helper.tab_class(tag).should eq("asphalt")
    end
  end
end