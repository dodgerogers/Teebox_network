class Answer < ActiveRecord::Base
  
  attr_accessible :body, :question_id, :votes_count, :correct
  validates_presence_of :body, :user_id, :question_id
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :votes, as: :votable, dependent: :destroy

  
  profanity_filter :body
  
  validates_uniqueness_of :correct, scope: :question_id, if: :correct?
  #validate :ensure_not_author
  
  
  def ensure_not_author 
     errors.add(:user_id, "You can't mark another users question") if self.user_id != self.question.user_id
  end
  
  def toggle_correct(attribute)
    toggle(attribute).update_attributes({attribute => self[attribute]})
  end  
end