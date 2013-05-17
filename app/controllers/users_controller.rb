class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
    @questions = @user.questions
    @videos = Video.where(user_id: current_user.id).all
    @video = Video.new
  end
end