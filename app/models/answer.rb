class Answer < ActiveRecord::Base
  
  attr_accessible :body, :question_id
  validates_presence_of :body, :user_id, :question_id
  belongs_to :user
  belongs_to :question
  
  profanity_filter :body

  

end