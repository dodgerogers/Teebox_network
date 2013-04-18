class Question < ActiveRecord::Base
  
  belongs_to :user
  has_many :videos, dependent: :destroy
  
  attr_accessible :title, :body, :user_id, :youtube_url, :video
  validates_presence_of :title, :body, :user_id
  
  default_scope order('created_at DESC')
end