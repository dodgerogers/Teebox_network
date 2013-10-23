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
    @activity = PublicActivity::Activity.find(params[:id])
    @activity.toggle(:read) if @activity.read == false
    if @activity.save
      redirect_to get_activity_path(@activity)
    else
      redirect_to root_path, notice: "Didnt work"  
    end
  end
  
  def get_notifications
    @notifications = PublicActivity::Activity.find_all_by_recipient_id(current_user.id, include: [:owner, :trackable], order: "created_at DESC")
  end
end