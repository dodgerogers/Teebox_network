class Question < ActiveRecord::Base
  
  belongs_to :user
  has_many :videos
  
  attr_accessible :title, :body, :user_id, :youtube_url, :video_id
  validates_presence_of :title, :body, :user_id
  validates_presence_of :video_id, allow_nil: false
  
  default_scope order('created_at DESC')
  
  def to_param
    "#{id} - #{title}".parameterize
  end
end