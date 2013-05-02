require 'file_size_validator'

class Video < ActiveRecord::Base
  
  attr_accessible :user_id, :question_id, :file, :screenshot
  belongs_to :question
  belongs_to :user
  
  default_scope order('created_at DESC')
  
  #after_create :take_screenshot
  
  #mount_uploader :file, VideoUploader
  mount_uploader :screenshot, ImageUploader
  
  #validates :file, presence: true, file_size: { maximum: 5.megabytes.to_i }
  validates_presence_of :user_id, :file
    
  def to_param
    "#{id} - #{File.basename(self.file)}".parameterize
  end
  
  def take_screenshot
    FFMPEG.ffmpeg_binary = '/opt/local/bin/ffmpeg'
    movie = FFMPEG::Movie.new(self.file)
    self.screenshot = movie.screenshot("#{Rails.root}/public/uploads/tmp/screenshots/#{File.basename(self.file)}.jpg", seek_time: 2 )
    self.save!
  end
end