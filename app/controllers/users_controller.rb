class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  before_filter :get_user, except: :index
  
  def show
    @decorator = UserDecorator.new(@user)
    @points = Point.find_points(@decorator)
  end
  
  def index
    @users = User.order("rank").reject { |n| n.rank == 0 }#.paginate(page: params[:page], per_page: 50)
  end
  
  def answers
    @answers = @user.answers.order("created_at desc").paginate(page: params[:page], per_page: 10).includes(:question)
  end
  
  def questions
    @questions = @user.questions.order("created_at desc").paginate(page: params[:page], per_page: 10)
  end
  
  def comments
    @comments = @user.comments.order("created_at desc").paginate(page: params[:page], per_page: 10).includes(:commentable)
  end
  
  def welcome
  end
  
  def get_user
    @user ||= User.find(params[:id])
  end
end