class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_user
  
  def show
    @decorator = UserDecorator.new(@user)
  end
  
  def get_user
    @user = User.find(params[:id])
  end
  
  def answers_index
    @answers = @user.answers.paginate(page: params[:page], per_page: 10).includes(:question)
  end
  
  def questions_index
    @questions = @user.questions.paginate(page: params[:page], per_page: 10)
  end
  
  def comments_index
    @comments = @user.comments.paginate(page: params[:page], per_page: 10).includes(:commentable)
  end
end