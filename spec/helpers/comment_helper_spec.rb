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
      helper.display_comments(@question).should eq "<div id=\"question_#{@question.id}_comments\"><section><a href=\"#\" class=\"toggle-comments\" data-div=\"question_#{@question.id}_comments\" data-url=\"http://test.host/questions/#{@question.id}-#{@question.title.parameterize}\">View 1 comment</a><div class=\"loading\">\n\t<img alt=\"Spinner\" src=\"/assets/spinner.gif\" />\n\tLoading comments...\n</div></section></div>"
    end
  end
end