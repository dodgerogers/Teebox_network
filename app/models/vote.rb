class Vote < ActiveRecord::Base
  
  attr_accessible :value, :votable_id, :votable_type
  belongs_to :votable, polymorphic: true
  belongs_to :user
  
  validates_inclusion_of :value, in: [1, -1]
  validates_presence_of :user_id, :value, :votable_id, :votable_type
  #validates_uniqueness_of :user_id, scope: :votable_id
  #validates_uniqueness_of :value, scope: :votable_id
  
  after_create :sum_votes
  after_create :user_reputation
  
  #validate :ensure_not_author
  
  def user_reputation
    votable = self.votable_type.downcase
    user_rep = self.votable.user
    if self.value == 1
      user_rep.update_attributes(reputation: (user_rep.reputation + 5))
    elsif self.value == -1
      user_rep.update_attributes(reputation: (user_rep.reputation - 3))
    end
  end
  
  def ensure_not_author 
    votable = self.votable_type.downcase
    errors.add(:user_id, "You can't vote on your own content") if self.votable.user_id == self.user_id
  end

  
  def sum_votes
    votable = self.votable_type.downcase.pluralize
    self.votable.update_attributes(votes_count: self.votable.votes.sum("value"))
  end
end