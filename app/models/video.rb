class Video < ActiveRecord::Base
  
  attr_accessible :user_id, :question_id, :file
  belongs_to :question
  belongs_to :user
  
  default_scope order('created_at DESC')
  
  mount_uploader :file, VideoUploader
  
end