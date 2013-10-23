class Comment < ActiveRecord::Base
  include PublicActivity::Common
  require 'obscenity/active_model'
  
  attr_accessible :content, :votes_count, :parent_id, :commentable_id, :commentable_type, :points
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :activities, class_name: "PublicActivity::Activity", as: :trackable, dependent: :destroy
  
  validates_presence_of :user_id, :content, :commentable_id, :commentable_type
  validates_length_of :content, minimum: 10, maximum: 350
  
  validates :content, obscenity: true
  
  after_create :display_mentions
  
  def display_mentions
    self.content.scan(/@([a-z0-9_]+)/i).flatten.each do |u|
      user = User.find_by_username(u)
      unless user == nil || self.user == user
        self.content.gsub!(/#{Regexp.escape("@#{u}")}/, "<a href='/users/#{user.id}-#{u}'>@#{u}</a>")
        self.delay.create_activity :create, owner: self.user, recipient: user unless user.id == self.commentable.user_id
      end
      self.save!
    end
  end
end