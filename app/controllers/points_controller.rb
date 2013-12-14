class PointsController < ApplicationController
  def index
    @points = Point.find_points(current_user).paginate(page: params[:page], per_page: 12)
    @user = User.find(params[:id])
  end
end