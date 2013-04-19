class Video < ActiveRecord::Base
  
  attr_accessible :user_id, :question_id, :file
  belongs_to :question
  belongs_to :user
  
  default_scope order('created_at DESC')
  
  before_save :take_screenshot
  
  mount_uploader :file, VideoUploader
  mount_uploader :screenshot, ImageUploader
  
  def to_param
    "#{id} - #{File.basename(self.file.path)}".parameterize
  end
  
  private 
  
  def take_screenshot
    FFMPEG.ffmpeg_binary = '/opt/local/bin/ffmpeg'
    movie = FFMPEG::Movie.new(self.file.current_path)
    self.screenshot = movie.screenshot("#{File.basename(self.file.path)}_screenshot.png", seek_time: 3 )
  end
end