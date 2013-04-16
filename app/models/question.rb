class Question < ActiveRecord::Base
  
  belongs_to :user
  has_many :videos
  #accepts_nested_attributes_for :videos, allow_destroy: true
  
  attr_accessible :title, :body, :user_id, :youtube_url#, :videos_attributes
  validates_presence_of :title, :body, :user_id
  
  default_scope order('created_at DESC')
end