class Question < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :video
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  
  attr_accessible :title, :body, :youtube_url, :video_id, :votes_count, :answers_count, :user_id
  validates_presence_of :title, :body, :user_id
  validates_presence_of :video_id, allow_nil: false
  
  profanity_filter :body, :title
  
  default_scope order('created_at DESC')
  
  def to_param
    "#{id} - #{title}".parameterize
  end
  
  def self.search(search)
    if search
      find(:all, conditions: [ 'title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end