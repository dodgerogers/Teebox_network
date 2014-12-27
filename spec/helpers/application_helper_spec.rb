require "spec_helper"

describe ApplicationHelper do 
  include Devise::TestHelpers
  before(:each) do
    @user1 = create(:user)
    @user2 = create(:user)
    @user1.confirm!
    @user2.confirm!
    sign_in @user1
    sign_in @user2
    @question = create(:question, user: @user1)
    @answer = create(:answer, user: @user1, question_id: @question.id)
    @comment = create(:comment, user: @user1, commentable: @question)
  end
  
  describe "demodularize" do
    it "returns first segment from module name" do
      helper.demodularize(Questions::ShowDecorator.new(@question)).should eq "Question"
    end
    
    it "returns class name" do
      helper.demodularize(@user1).should eq "User"
    end
  end
  
  describe "strip_links_and_trim" do
    it "strips html tags and truncates string" do
      text = "<a href='#'>hello</a> this text contains <div>html</div>"
      helper.strip_links_and_trim(text).should eq "hello this text contains html"
    end
  end
  
  describe "profile_link_helper" do
    it "returns formatted html" do
      avatar_url = Digest::MD5.hexdigest(@user1.email.downcase)
      profile_link = helper.profile_link_helper(@answer)
      profile_link.should include @user1.to_param
      profile_link.should include avatar_url.titleize
      profile_link.should include avatar_url
      profile_link.should include @user1.username.titleize
    end
  end
  
  describe "social_links" do
    it "returns formatted social links" do
      page = "/questions"
      links = helper.social_links(page)
      links.should include "http://facebook.com/sharer.php?u=/questions"
      links.should include "https://plus.google.com/share?url=/questions"
      links.should include "https://twitter.com/share?url=/questions"
      links.should include "https://www.linkedin.com/cws/share?url=/questions"
    end
  end
  
  describe "personal_links" do
    it "returns formatted personal links" do
      links = helper.personal_links
      links.should include "https://twitter.com/AndrewRogers747" 
      links.should include "https://plus.google.com/+andyrogers747/" 
      links.should include "http://www.linkedin.com/profile/view?id=52220364&amp;trk=nav_responsive_tab_profile" 
      links.should include "https://gist.github.com/dodgerogers"
    end
  end
  
  describe "avatar url" do
    it "returns a href" do
      @gravatar_id = Digest::MD5.hexdigest(@user2.email.downcase)
      helper.avatar_url(@user2).should eq "http://gravatar.com/avatar/#{@gravatar_id}.png?s=35&d=identicon"
    end
  end
  
  describe "meta_info" do
    it "returns formatted links for a question" do
      html = helper.meta_info(@question)
      
      html.should have_selector("ul.meta_info")
      html.should have_selector('a#profile-reputation')
      html.should have_selector('i.icon-calendar')
      html.should have_selector('i.icon-eye-open')
      html.should have_selector('div#arrows')
    end
    
    it "includes custom html when html passed to block" do
      html = helper.meta_info(@question) { "this is some custom html" }
      
      html.should have_selector("ul.meta_info")
      html.should have_selector('a#profile-reputation')
      html.should have_selector('i.icon-calendar')
      html.should have_selector('div#arrows')
      html.should include("this is some custom html")
    end
    
    it "returns formatted links for an answer" do
      html = helper.meta_info(@answer)
      
      html.should have_selector("ul.meta_info")
      html.should have_selector('a#profile-reputation')
      html.should have_selector('i.icon-calendar')
      html.should have_selector('div#arrows')
      html.should have_selector('li.default-tick')
    end
    
    it "returns formatted links for a comment" do
      html = helper.meta_info(@comment)
      
      html.should have_selector("ul.meta_info")
      html.should have_selector('a#profile-reputation')
      html.should have_selector('i.icon-calendar')
      html.should have_selector('div#arrows')
    end
  end
end


