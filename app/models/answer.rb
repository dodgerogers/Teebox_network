class Answer < ActiveRecord::Base
  
  include PublicActivity::Common
  include Teebox::Activity
  include Teebox::Toggle
  require 'obscenity/active_model'
  
  attr_accessible :body, :question_id, :votes_count, :correct, :points
  
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
   
  validates_presence_of :body, :user_id, :question_id
  validates_length_of :body, minimum: 10, maximum: 5000
  validates_uniqueness_of :correct, scope: :question_id, if: :correct?, message: "You can only have 1 correct answer per question"
  validates_uniqueness_of :user_id, scope: :question_id, message: "Only 1 answer per question per user"
  validates :body, obscenity: true
  
  scope :by_votes, order: "votes_count DESC"
  
  def is_false?
    self.user == self.question.user || self.correct == false
  end
end