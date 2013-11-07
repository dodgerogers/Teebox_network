class User < ActiveRecord::Base
  # :token_authenticatable
  # :lockable, :timeoutable and :omniauthable
  include PublicActivity::Common
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable 

  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :reputation, :rank
  validates :username, presence: true, uniqueness: true, length: { maximum: 30 }

  has_many :questions, dependent: :destroy
  has_many :videos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :tags
  
  after_create :create_welcome_notification
  
  ROLES = %w[admin tester standard]
  
  def to_param
    "#{id} - #{username}".parameterize
  end
  
  def create_welcome_notification
    self.create_activity :create, recipient: self
  end
  
  #Devise delayed mailers
  def send_on_create_confirmation_instructions
    Devise::Mailer.delay.confirmation_instructions(self)
  end

  #def send_reset_password_instructions
  #  Devise::Mailer.delay.reset_password_instructions(self)
  #end

  #def send_unlock_instructions
  #  Devise::Mailer.delay.unlock_instructions(self)
  #end
end
