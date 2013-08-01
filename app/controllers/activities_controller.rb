class ActivitiesController < ApplicationController
  
  def index
    @activities = notifications.paginate(page: params[:page], per_page: 20)
  end
end