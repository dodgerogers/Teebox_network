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
  
  describe "demodularize()" do
    it "returns first segment from module name" do
      helper.demodularize(Questions::ShowDecorator.new(@question)).should eq "Question"
    end
    
    it "returns class name" do
      helper.demodularize(@user1).should eq "User"
    end
  end
  
  describe "meta_info" do
    it "returns formatted profile links" do
      helper.meta_info(@question).should eq "<span class=\"meta_info\"><i class=\"icon-user\"></i><a href=\"/users/#{@user1.id}-#{@user1.username}\" class=\"user_#{@user1.id}\" id=\"profile-reputation\">200</a><a href=\"/users/#{@user1.id}-#{@user1.username}\">#{@user1.username}</a><i class=\"icon-calendar\"></i>less than a minute ago <div class=\"vote-box\">\n\t<i class=\"icon-thumbs-up-alt\"></i>\n\t<span id=\"Question_#{@question.id}\">\n\t\t5 votes\n\t</span>\n</div>\n<div id=\"arrows\">\n\t<a href=\"/questions/#{@question.id}-#{@question.title.parameterize}/vote?value=1\" data-method=\"post\" data-remote=\"true\" id=\"upvote\" rel=\"nofollow\" title=\"Upvote\"><i class='icon-plus-sign-alt green sm'></i></a>\n\t<a href=\"/questions/#{@question.id}-#{@question.title.parameterize}/vote?value=-1\" data-method=\"post\" data-remote=\"true\" id=\"downvote\" rel=\"nofollow\" title=\"Downvote\"><i class='icon-minus-sign-alt red sm'></i></a>\n</div></span>"
    end
  end
  
  describe "profile_link_helper" do
    it "returns formatted html" do
      @answer = create(:answer, user: @user1, question_id: @question.id)
      avatar_url = Digest::MD5.hexdigest(@user1.email.downcase)
      helper.profile_link_helper(@answer).should eq "<div class=\"profile\"><a href=\"/users/#{@user1.to_param}\"><img alt=\"#{avatar_url.titleize}\" src=\"http://gravatar.com/avatar/#{avatar_url}.png?s=35&amp;d=identicon\" /></a><a href=\"/users/#{@user1.to_param}\" class=\"user_#{@user1.id}\" id=\"profile-reputation\">200</a><a href=\"/users/#{@user1.to_param}\" id=\"profile-username\">#{@user1.username.titleize}</a><br><small>less than a minute ago</small></div>".html_safe
    end
  end
  
  describe "social_links" do
    it "returns formatted social links" do
      page = "/questions"
      helper.social_links(page).should eq "<div><a href=\"http://facebook.com/sharer.php?u=/questions\" target=\"_blank\"><i class='icon-facebook-sign medium facebook'></i> </a><a href=\"https://plus.google.com/share?url=/questions\" target=\"_blank\"><i class='icon-google-plus-sign medium google'></i> </a><a href=\"https://twitter.com/share?url=/questions\" target=\"_blank\"><i class='icon-twitter medium twitter'></i> </a></div>"
    end
  end
  
  describe "personal_links" do
    it "returns formatted personal links" do
      helper.personal_links.should eq "<span><a href=\"https://twitter.com/AndrewRogers747\" target=\"_blank\"><i class='icon-twitter twitter'></i> </a><a href=\"https://plus.google.com/+andyrogers747/\" target=\"_blank\"><i class='icon-google-plus-sign google'></i> </a><a href=\"http://www.linkedin.com/profile/view?id=52220364&amp;trk=nav_responsive_tab_profile\" target=\"_blank\"><i class='icon-linkedin facebook'></i> </a><a href=\"https://gist.github.com/dodgerogers\" target=\"_blank\"><i class='icon-github-alt'></i></a></span>"
    end
  end
  
  describe "avatar url" do
    it "returns a href" do
      @gravatar_id = Digest::MD5.hexdigest(@user2.email.downcase)
      helper.avatar_url(@user2).should eq "http://gravatar.com/avatar/#{@gravatar_id}.png?s=35&d=identicon"
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


