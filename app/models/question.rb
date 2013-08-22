class Question < ActiveRecord::Base
  include AnswerHelper
  
  attr_accessible :title, :body, :youtube_url, :video_id, :votes_count, :answers_count, :points, :correct, :tag_tokens
  attr_reader :tag_tokens
  
  belongs_to :user
  belongs_to :video
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  validates_presence_of :title, :body, :user_id
  validates_length_of :title, minimum: 10, maximum: 90
  validate :tag_limit
  
  #validate only own videos used
  
  profanity_filter :body, :title
  
  scope :unanswered, conditions: { correct: false }
  scope :by_votes, order: "votes_count DESC"
  scope :newest, order: "created_at DESC"
      
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
  
  def tag_tokens=(tokens)
    self.tag_ids = Tag.ids_from_tokens(tokens)
  end
  
  def self.tagged_with(name)
    Tag.find_by_name!(name).questions
  end
  
  def tag_limit
    errors.add(:tag_tokens, "Maximum of 5 Tags per Question") if self.tags.size > 5 if self.tags
  end
end