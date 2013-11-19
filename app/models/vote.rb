class Vote < ActiveRecord::Base
  
  attr_accessible :value, :votable_id, :votable_type, :points
  belongs_to :votable, polymorphic: true
  belongs_to :user
  
  validates_inclusion_of :value, in: [1, -1]
  validates_presence_of :user_id, :value, :votable_id, :votable_type, :points
  validates_uniqueness_of :value, scope: [:votable_id, :user_id]
  validate :ensure_not_author
  
  before_validation :create_points
  
  def ensure_not_author 
    if self.votable
      errors.add(:user_id, "You can't vote on your own content.") if self.votable.user_id == self.user_id
    end
  end
  
  def create_points
    self.value == 1 ? self.points = 5 : self.points = -5
  end
  
  def user_rep
    self.votable.user
  end
  
  def sum_points(column)
    self.votable.votes.sum(column)
  end
end