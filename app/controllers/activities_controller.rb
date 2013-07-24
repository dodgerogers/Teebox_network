class ActivitiesController < ApplicationController
  def index
    @activities = PublicActivity::Activity.order("created_at DESC").where(recipient_id: current_user.id)
  end
end