require "spec_helper"

describe CommentHelper do
  include Devise::TestHelpers
  before(:each) do
    @user = create(:user)
    @user.confirm!
    sign_in @user
    @question = create(:question, user: @user)
    @comment = create(:comment, commentable_id: @question.id, user: @user)
    controller.stub!(:current_user).and_return(@user)
  end
  
  describe "display_comments" do
    it "renders <section> div" do
      @question.comments << @comment
      @question.reload
      html = helper.display_comments(@question)
      
      html.should have_selector('section')
      html.should include "#{@question.id}-#{@question.title.parameterize}"
      html.should include "View 1 comment"
    end
  end
end