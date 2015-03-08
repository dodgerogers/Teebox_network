class VotesController < ApplicationController
  
  before_filter :authenticate_user!
  
  def create
    @vote = current_user.votes.build(params[:vote])
    respond_to do |format|
      if @vote.save
        PointRepository.create(@vote.votable.user, @vote, @vote.points)
        format.html { redirect_to :back, notice: "Vote submitted" }
        format.js
      else
        format.html { redirect_to :back, alert: "Vote submission failed" }
        format.js
      end
    end
  end
end