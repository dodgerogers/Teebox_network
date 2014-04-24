class Answer < ActiveRecord::Base
  include PublicActivity::Common
  include Teebox::Activity
  include Teebox::Toggle
  require 'obscenity/active_model'
  
  attr_accessible :body, :question_id, :votes_count, :correct, :points, :comments_count
  
  belongs_to :user
  belongs_to :question, counter_cache: true
  has_many :votes, as: :votable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_one :point, as: :pointable, dependent: :destroy
   
  validates_presence_of :body, :user_id, :question_id
  validates_length_of :body, minimum: 10, maximum: 5000
  validates_uniqueness_of :correct, scope: :question_id, if: :correct?, message: "You can only have 1 correct answer per question"
  validates_uniqueness_of :user_id, scope: :question_id, message: "Only 1 answer per question per user"
  validates :body, obscenity: true
  
  before_destroy :check_correct
  
  default_scope include: :question
  scope :by_votes, order: "votes_count DESC"
  
  def to_param
    "#{id} - #{question.title}".parameterize
  end
  
  def is_false?
    self.user == self.question.user || self.correct == false
  end
  
  def check_correct
    errors.add(:base, "You can't delete a correct answer") if self.correct == true
    errors.blank?
  end
end