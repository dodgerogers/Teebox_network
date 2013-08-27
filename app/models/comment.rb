class Comment < ActiveRecord::Base
  include PublicActivity::Common
  require 'obscenity/active_model'
  
  attr_accessible :content, :votes_count, :commentable_id, :commentable_type, :points
  
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :votes, as: :votable, dependent: :destroy
  has_many :activities, class_name: "PublicActivity::Activity", as: :trackable, dependent: :destroy
  
  validates_presence_of :user_id, :content, :commentable_id, :commentable_type
  validates_length_of :content, minimum: 10
  
  validates :content, obscenity: true
    
end