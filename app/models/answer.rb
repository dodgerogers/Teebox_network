class Answer < ActiveRecord::Base
  include AnswerHelper
  
  attr_accessible :body, :question_id, :votes_count, :correct, :user_id, :points
  validates_presence_of :body, :user_id, :question_id
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :votes, as: :votable, dependent: :destroy
  
  profanity_filter :body
  
  #only one answer can be marked as correct
  validates_uniqueness_of :correct, scope: :question_id, if: :correct?
  
  #only 1 answer per question per user
  validates_uniqueness_of :user_id, scope: :question_id
  
  def toggle_question_correct
    self.question.toggle_correct(:correct)
  end
  
  #validate answer only toggled once, or user rep on toggled once when correct answer is marked
  
  def add_reputation
    user = self.user
    if self.correct == true && user != self.question.user
      user.update_attributes(reputation: (user.reputation + 20)) 
      self.question.user.update_attributes(reputation: (self.question.user.reputation + 5)) 
    end
  end 
end