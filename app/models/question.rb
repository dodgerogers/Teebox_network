class Question < ActiveRecord::Base
  include AnswerHelper
  
  attr_accessible :title, :body, :youtube_url, :video_id, :user_id, :votes_count, :answers_count, :points, :correct, :tag_tokens
  attr_reader :tag_tokens
  
  belongs_to :user
  belongs_to :video
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :taggings
  has_many :tags, through: :taggings

  validates_presence_of :title, :body, :user_id
  validates_presence_of :video_id, allow_nil: false
  
  profanity_filter :body, :title
  
  default_scope order('created_at DESC')
  
  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end
  
  def self.tagged_with(name)
    Tag.find_by_name!(name).questions
  end
  
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