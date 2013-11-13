class VoteObserver < ActiveRecord::Observer
  
  def after_create(vote)
    vote.user_rep.update_attributes(reputation: (vote.user_rep.reputation + vote.points))
    vote.votable.update_attributes(votes_count: vote.sum_points("value"), points: vote.sum_points("points"))
  end
end