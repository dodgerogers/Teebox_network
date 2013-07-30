class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at DESC").where(recipient_id: current_user.id).paginate(page: params[:page], per_page: 20)
  end
end