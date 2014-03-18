require "active_support/concern"

module Teebox::Votable
  extend ActiveSupport::Concern
  
  included do
    before_filter :create_vote, only: :vote
  end
  
  def create_vote
    @vote = current_user.votes.build(value: params[:value], votable_id: params[:id], votable_type: self.controller_name.singularize.capitalize.to_s)
    respond_to do |format|
      if @vote.save
        Teebox::Pointable.create(@vote.votable.user, @vote, @vote.points)
        format.html { redirect_to :back, notice: "Vote submitted" }
        format.js { render partial: "votes/vote" }
      else
        format.html { redirect_to :back, alert: "Vote submission failed" }
        format.js { render partial: "votes/vote" }
      end
    end
  end
end