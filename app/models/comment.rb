class Comment < ActiveRecord::Base
  
  attr_accessible :content, :votes_count, :user_id, :commentable_id, :commentable_type
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  
  validates_presence_of :user_id, :content, :commentable_id, :commentable_type
  
  profanity_filter :content
end