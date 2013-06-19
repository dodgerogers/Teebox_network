class VoteObserver < ActiveRecord::Observer
  
  def after_create(vote)
      votable = vote.votable_type.downcase
      user_rep = vote.votable.user
      user_rep.update_attributes(reputation: (user_rep.reputation + vote.points))
      votable = vote.votable_type.downcase.pluralize
      vote.votable.update_attributes(votes_count: vote.votable.votes.sum("value"), points: vote.votable.votes.sum("points"))
  end
end