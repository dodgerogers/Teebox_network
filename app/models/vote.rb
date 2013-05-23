class Vote < ActiveRecord::Base
  
  attr_accessible :value, :user_id
  belongs_to :votable, polymorphic: true
  belongs_to :user
  
  validates_presence_of :user_id, :value, :votable_id, :votable_type
  
end