class Comment < ActiveRecord::Base
  attr_accessible :content
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  
  validates_presence_of :user_id, :content, :commentable_id, :commentable_type
  
  profanity_filter :content
end