class Vote < ActiveRecord::Base
  
  attr_accessible :value, :votable_id, :votable_type
  belongs_to :votable, polymorphic: true
  belongs_to :user
  
  validates_inclusion_of :value, in: [1, -1]
  validates_presence_of :user_id, :value, :votable_id, :votable_type
  #validates_uniqueness_of :user_id, scope: :votable_id
  #validates_uniqueness_of :value, scope: :votable_id
  
  #validate :ensure_not_author
  
  before_save :create_points
  
  def ensure_not_author 
    votable = self.votable_type.downcase
    errors.add(:user_id, "You can't vote on your own content") if self.votable.user_id == self.user_id
  end
  
  def create_points
    self.value == 1 ? self.points = 5 : self.points = -3
  end
end