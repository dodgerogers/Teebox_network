class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @video = Video.new
    @questions = @user.questions
    @answers = @user.answers.includes(:question)
    @comments = @user.comments.includes(:commentable)
  end
end