class Question < ActiveRecord::Base
  include Teebox::Toggle
  include Teebox::Impressionable
  require 'obscenity/active_model'
  
  attr_accessible :title, :body, :youtube_url, :votes_count, :answers_count, :points, :correct, :tag_tokens, :video_list
  #remove video_id, plus points
  attr_reader :tag_tokens
  
  belongs_to :user
  has_many :videos, through: :playlists
  has_many :playlists, dependent: :destroy
  
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings
  has_one :point, as: :pointable, dependent: :destroy

  validates_presence_of :title, :body, :user_id
  validates_length_of :title, minimum: 10, maximum: 85
  validate :tag_limit, :video_limit
  #validate :ensure_own_video
  
  validates :body, obscenity: true
  validates :title, obscenity: true
  
  scope :unanswered, conditions: { correct: false }
  scope :popular, order: "votes_count DESC"
  scope :newest, order: "created_at DESC"
  
  def video_list
    self.videos.map(&:id).join(",")
  end
  
  def video_list=(ids)
    self.videos = ids.split(",").map { |n| Video.find(n) }
  end
  
  def video_limit
    errors.add(:video_list, "Maximum of 3 videos") if self.videos.size > 3 if self.videos
  end
  
  # WILL BE AFFECTED, Only for admins anyway
  # def ensure_own_video 
  #     if self.video
  #       errors.add(:video_id, "You can only use your own videos") if self.video.user.id != self.user_id
  #     end
  #   end
      
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