class Answer < ActiveRecord::Base
  
  attr_accessible :body, :question_id, :votes_count, :correct, :user_id, :points
  validates_presence_of :body, :user_id, :question_id
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :votes, as: :votable, dependent: :destroy
  
  profanity_filter :body
  
  validates_uniqueness_of :correct, scope: :question_id, if: :correct?
  #validates_uniqueness_of :user_id, scope: :question_id
  #validate :ensure_not_author  
  
  
  def ensure_not_author 
     errors.add(:user_id, "You can't mark another users question") if self.user_id != self.question.user_id
  end
  
  #if an answer correct column toggled, update the correct answer column in the question
  def toggle_question_correct
    self.question.toggle_correct(:correct)
  end
  
  def add_reputation
    user = self.user
    if self.correct == true && user != self.question.user
      user.update_attributes(reputation: (user.reputation + 20)) 
      self.question.user.update_attributes(reputation: (self.question.user.reputation + 5)) 
    end
  end 
end