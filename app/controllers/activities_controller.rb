class ActivitiesController < ApplicationController
  include ActivityHelper
  
  before_filter :authenticate_user!
  before_filter :get_notifications
  
  def index
    @activities = @notifications.paginate(page: params[:page], per_page: 20)
  end
  
  def notifications
    respond_to do |format|
      format.html { render partial: "activities/index", locals: { activities: @notifications }   }
      format.js { render partial: "activities/index" }
    end
  end
  
  def read
    @activity = Activity.find(params[:id])
    @activity.read_activity
    if @activity.save
      redirect_to build_activity_path(@activity)
    else
      redirect_to root_path, notice: "Fraid we couldn't do that"  
    end
  end
  
  def get_notifications
    @notifications = Activity.user_notifications(current_user)
  end
end