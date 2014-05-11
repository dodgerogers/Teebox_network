class Comment < ActiveRecord::Base
  
  include PublicActivity::Common
  include Teebox::Activity
  require 'obscenity/active_model'
  
  attr_accessible :content, :votes_count, :parent_id, :commentable_id, :commentable_type, :points
  
  belongs_to :commentable, polymorphic: true, counter_cache: true
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  has_one :point, as: :pointable, dependent: :destroy
  
  validates_presence_of :user_id, :content, :commentable_id, :commentable_type
  validates_length_of :content, minimum: 10
  validate :content_minus_links
  validates :content, obscenity: true
  
  with_options if: "find_mentions.any?" do
    validate :mentions_limit
    after_create :display_mentions
  end
  
  default_scope order: "created_at"
  
  def find_mentions
    @mentions ||= self.content.scan(/@([a-z0-9_]+)/i).flatten
  end
  
  def content_minus_links
    return unless errors.blank?
    if ActionController::Base.helpers.strip_links(self.content).each_char.count > 500
      errors.add(:content, "exceeds 500 characters")
    end
  end
  
  def mentions_limit
    return unless errors.blank?
    if find_mentions.uniq.length != find_mentions.length
      errors.add(:content, "You can only mention someone once") 
    end
  end
  
  def display_mentions
    find_mentions.each do |u|
      user = User.where(username: u)[0]
      unless (user == nil || self.user == user)
        self.content.gsub!(/#{Regexp.escape("@#{u}")}/, "<a href='/users/#{user.id}-#{u}'>@#{u}</a>")
        self.create_activity :create, owner: self.user, recipient: user unless user.id == self.commentable.user_id
      end
    end
    self.save!
  end
end