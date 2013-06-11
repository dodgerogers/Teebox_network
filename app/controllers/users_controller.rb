class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @questions = @user.questions.page(params[:page]).per_page(6)
    @video = Video.new
    @answers = @user.answers.page(params[:page]).per_page(6)
  end
end