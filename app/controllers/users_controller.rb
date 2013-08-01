class UsersController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @user = User.find(params[:id])
    @decorator = UserDecorator.new(@user)
  end
end