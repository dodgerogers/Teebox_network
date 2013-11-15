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
  end
  
  describe "profile_link_helper" do
    it "returns formatted html" do
      @answer = create(:answer, user: @user1, question_id: @question.id)
      avatar_url = Digest::MD5.hexdigest(@user1.email.downcase)
      helper.profile_link_helper(@answer).should eq "<div class=\"profile\"><a href=\"/users/#{@user1.to_param}\"><img alt=\"#{avatar_url.titleize}\" src=\"http://gravatar.com/avatar/#{avatar_url}.png?s=35&amp;d=identicon\" /></a><a href=\"/users/#{@user1.to_param}\" id=\"profile-reputation\">200</a><a href=\"/users/#{@user1.to_param}\" id=\"profile-username\">#{@user1.username.titleize}</a><br>Posted less than a minute ago</div>".html_safe
    end
  end
  
  describe "social_links" do
    it "returns formatted social links" do
      page = "/questions"
      helper.social_links(page).should eq "<div><a href=\"http://facebook.com/sharer.php?u=/questions\" target=\"_blank\"><i class='icon-facebook-sign large facebook'></i> </a><a href=\"https://plus.google.com/share?url=/questions\" target=\"_blank\"><i class='icon-google-plus-sign large google'></i> </a><a href=\"https://twitter.com/share?url=/questions\" target=\"_blank\"><i class='icon-twitter large twitter'></i> </a></div>"
    end
  end
  
  describe "avatar url" do
    it "returns a href" do
      @gravatar_id = Digest::MD5.hexdigest(@user2.email.downcase)
      helper.avatar_url(@user2).should eq "http://gravatar.com/avatar/#{@gravatar_id}.png?s=35&d=identicon"
    end
  end
  
  describe "points_from_correct" do
    it "returns no correct answers" do
      @question = create(:question)
      @answer = create(:answer, question_id: @question.id, correct: false)
      helper.points_from_correct(@question).should eq nil
    end
    
    it "returns +5 points" do
      @question = create(:question, user_id: @user1.id, correct: true)
      @answer = create(:answer, user_id: @user2.id, question_id: @question.id, correct: true)
      helper.points_from_correct(@question).should eq "+5"
    end
  end
  
  describe "hide footer" do
    it "shouldn't hide footer on home page" do
      helper.hide_footer.should eq ''
    end
  end
  
  describe "percent_of" do
    it "calculates correct -% when value a == 0" do
      helper.percent_of(0, rand(1..200)).should eq(-100)
    end
    
    it "calculates correct +% when value b == 0" do
      helper.percent_of(rand(1..200), 0).should eq(100)
    end
    
    it "calculates correct +% when value values > 0" do
      helper.percent_of(2, 5).should eq(-60)
    end
  end
end


