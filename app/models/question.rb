class Question < ActiveRecord::Base
  include AnswerHelper
  require 'obscenity/active_model'
  
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
  validate :ensure_own_video
  
  validates :body, obscenity: true
  validates :title, obscenity: true
  
  scope :unanswered, conditions: { correct: false }
  scope :by_votes, order: "votes_count DESC"
  scope :newest, order: "created_at DESC"
  
  def ensure_own_video 
    if self.video
      errors.add(:video_id, "You can only use your own videos") if self.video.user.id != self.user_id
    end
  end
      
  def to_param
    "#{id} - #{title}".parameterize
  end
  
  include PgSearch
  pg_search_scope :search, against: [:title], 
    using: { tsearch: { prefix: true, 
                        dictionary: "english",
                        any_word: true } }
  
  def self.text_search(query)
    if query.present?
      search(sanitize(query))
    else
      scoped
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