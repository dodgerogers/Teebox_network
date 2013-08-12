class ActivitiesController < ApplicationController
  include ActivityHelper
  
  before_filter :authenticate_user!
  before_filter :get_notifications, only: [:index, :notifications]
  
  def index
    @activities = @notifications.paginate(page: params[:page], per_page: 20)
  end
  
  def notifications
    respond_to do |format|
      format.html { render partial: "activities/index", locals: { activities: @notifications }   }
      format.js { render partial: "activities/index" }
    end
  end
  
  def get_notifications
    @notifications = user_activities(current_user)
  end
end