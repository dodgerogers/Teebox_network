class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @presenter = UserPresenter.new(@user)
  end
end