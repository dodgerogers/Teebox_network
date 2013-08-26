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
  end
  
  describe "profile_link_helper" do
    it "returns formatted html" do
      @answer = create(:answer, user: @user1)
      avatar_url = Digest::MD5.hexdigest(@user1.email.downcase)
      helper.profile_link_helper(@answer).should eq "<a href=\"/users/#{@user1.to_param}\"><img alt=\"#{avatar_url.titleize}\" src=\"http://gravatar.com/avatar/#{avatar_url}.png?s=35&amp;d=identicon\" /></a><a href=\"/users/#{@user1.to_param}\" id=\"profile-reputation\">200</a><a href=\"/users/#{@user1.to_param}\" id=\"profile-username\">#{@user1.username.titleize}</a><br>Posted less than a minute ago".html_safe
    end
  end
  
  describe "edit_delete_link helper" do
    it "returns formatted html" do
      current_user = @user1
      @answer = create(:answer, user: @user1)
      helper.edit_delete_links(@answer, { path: edit_answer_path(@answer), delete_id: "delete-answer", edit_id: "edit-answer" }).should eq "<a href=\"/answers/1\" data-confirm=\"Are you sure\" data-method=\"delete\" data-remote=\"true\" id=\"delete-answer\" rel=\"nofollow\">Delete </a><a href=\"/answers/1/edit\" data-remote=\"true\" id=\"edit-answer\">Edit</a>".html_safe
    end
  end
  
  describe "avatar url" do
    it "returns a href" do
      @gravatar_id = Digest::MD5.hexdigest(@user2.email.downcase)
      helper.avatar_url(@user2).should eq "http://gravatar.com/avatar/#{@gravatar_id}.png?s=35&d=identicon"
    end
  end
  
  describe "clickable_links" do
    it "returns a link" do
      helper.clickable_links("http://www.teebox.co").should eq "<a href=\"http://www.teebox.co\">http://www.teebox.co</a>".html_safe
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


