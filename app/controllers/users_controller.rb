class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_user, except: :index
  
  def show
    @decorator = UserDecorator.new(@user)
  end
  
  def index
    @users = User.order("rank").paginate(page: params[:page], per_page: 50)
  end
  
  def get_user
    @user = User.find(params[:id])
  end
  
  def answers_index
    @answers = @user.answers.order("created_at desc").paginate(page: params[:page], per_page: 10).includes(:question)
  end
  
  def questions_index
    @questions = @user.questions.order("created_at desc").paginate(page: params[:page], per_page: 10)
  end
  
  def comments_index
    @comments = @user.comments.order("created_at desc").paginate(page: params[:page], per_page: 10).includes(:commentable)
  end
end