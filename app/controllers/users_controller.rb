class UsersController < ApplicationController
  
  before_filter :authenticate_user!, :get_user
  
  def show
    @user = User.find(params[:id])
    @decorator = UserDecorator.new(@user)
  end
  
  private
  
  def get_user
    @user = User.find(params[:id])
  end
end