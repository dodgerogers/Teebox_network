class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id], include: [:questions, :answers, :comments])
    @video = Video.new
  end
end