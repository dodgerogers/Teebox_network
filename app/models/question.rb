class Question < ActiveRecord::Base
  
  belongs_to :user
  has_many :videos
  
  attr_accessible :title, :body, :user_id
  validates_presence_of :title, :body, :user_id
  
  default_scope order('created_at DESC')
end