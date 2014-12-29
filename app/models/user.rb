class User < ActiveRecord::Base
  include PublicActivity::Common
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :reputation, :rank
  
  serializeable :preferences, { notifications: "1" }
  
  validates :username, presence: true, uniqueness: true, length: { maximum: 30 }

  has_many :questions, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :tags
  has_many :points, dependent: :destroy

  after_create :create_welcome_notification
  
  ROLES = %w[admin tester standard]
  
  def to_param
    "#{id} - #{username}".parameterize
  end
  
  def create_welcome_notification
    repo = ActivityRepository.new(self)
    repo.generate(:create, recipient: self)
  end
  
  def send_on_create_confirmation_instructions
    Devise::Mailer.delay.confirmation_instructions(self)
  end
  
  def self.rank_by_reputation
    results = {}
    self.order("reputation desc").each do |user| 
       results[user.reputation] = self.where(reputation: user.reputation).map(&:id)
    end
    return results
  end
  
  def self.rank_users
    self.rank_by_reputation.each_with_index do |users, rank|
      self.where(id: users[1]).update_all(rank: rank + 1)
    end
  end
  
  def notification_message_format
    { 
      link: 'here', 
      text: 'Need a refresher on how it works? Click' 
    }
  end
end