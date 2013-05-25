class Vote < ActiveRecord::Base
  
  attr_accessible :value, :votable_id, :votable_type
  belongs_to :votable, polymorphic: true
  belongs_to :user
  
  validates_inclusion_of :value, in: [1, -1]
  validates_presence_of :user_id, :value, :votable_id, :votable_type
  after_create :sum_votes
  
  #validate :ensure_not_author
  
  #def ensure_not_author
    #find votable object, then use votable.self.user_id == self.user_id is not cool!
  #end
  
  def sum_votes
    votable = self.votable_type.downcase.pluralize
    self.votable.update_attributes(votes_count: self.votable.votes.sum("value"))
  end
end