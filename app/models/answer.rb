class Answer < ActiveRecord::Base
  include AnswerHelper
  include PublicActivity::Common
  
  attr_accessible :body, :question_id, :votes_count, :correct, :points
  
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  
  validates_presence_of :body, :user_id, :question_id
  validates_length_of :body, minimum: 10
  #only one answer can be marked as correct
  validates_uniqueness_of :correct, scope: :question_id, if: :correct?
  #only 1 answer per question per user
  validates_uniqueness_of :user_id, scope: :question_id
  
  profanity_filter :body
  
  scope :by_votes, order: "votes_count DESC"
  
  def toggle_question_correct
    self.question.toggle_correct(:correct)
  end
  
  def add_reputation
    if truthness(self, true)
      update_reputations(self, 20, 5, :+)
    elsif truthness(self, false)
      update_reputations(self, 20, 5, :-)
    end
  end 
  
  private
  
  def truthness(answer, truth)
    answer.correct == truth && answer.user != answer.question.user
  end
  
  def update_reputations(answer, your_rep, my_rep, operator)
    answer.user.update_attributes(reputation: (answer.user.reputation.send(operator, your_rep)))
    answer.question.user.update_attributes(reputation: (answer.question.user.reputation.send(operator, my_rep)))
  end
end