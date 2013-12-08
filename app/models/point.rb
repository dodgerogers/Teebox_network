class Point < ActiveRecord::Base
  
  after_create :user_reputation
  after_destroy :user_reputation
  
  attr_accessible :value, :pointable_id, :pointable_type
  belongs_to :user
  belongs_to :pointable, polymorphic: true

  def user_reputation
    self.user.update_attributes(reputation: self.user.points.sum("value"))
  end
  
  # vote.user_rep.update_attributes(reputation: (vote.user_rep.reputation + vote.points))
  # vote.votable.update_attributes(votes_count: vote.sum_points("value"), points: vote.sum_points("points"))

  
  # def after_create(vote)
  #     vote.user_rep.update_attributes(reputation: (vote.user_rep.reputation + vote.points))
  #     vote.votable.update_attributes(votes_count: vote.sum_points("value"), points: vote.sum_points("points"))
  #   end
  #   
  #   def update_answer_user_rep(points, operator)
  #     @answer.user.update_attributes(reputation: (@answer.user.reputation.send(operator, points)))
  #   end
  #   
  #   def update_question_user_rep(points, operator)
  #     @answer.question.user.update_attributes(reputation: (@answer.question.user.reputation.send(operator, points)))
  #   end
end