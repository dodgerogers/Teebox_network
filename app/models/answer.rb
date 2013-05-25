class Answer < ActiveRecord::Base
  
  attr_accessible :body, :question_id, :votes_count
  validates_presence_of :body, :user_id, :question_id
  belongs_to :user
  belongs_to :question
  has_many :votes, as: :votable, dependent: :destroy
  
  profanity_filter :body

  

end