require 'file_size_validator'

class Video < ActiveRecord::Base
  
  attr_accessible :user_id, :question_id, :file, :screenshot
  belongs_to :question
  belongs_to :user
  
  default_scope order('created_at DESC')
  
  before_save :take_screenshot
  #after_save :run_rake
  
  mount_uploader :file, VideoUploader
  mount_uploader :screenshot, ImageUploader
  
  validates :file, presence: true, file_size: { maximum: 5.megabytes.to_i }
  
  #def run_rake
   # load File.join(Rails.root, 'lib', 'tasks', 'video.rake')
   # Rake::Task['delete_screenshots'].invoke
  #end
  
  def to_param
    "#{id} - #{File.basename(self.file.path)}".parameterize
  end
  
  private
  
  def take_screenshot
    FFMPEG.ffmpeg_binary = '/opt/local/bin/ffmpeg'
    movie = FFMPEG::Movie.new(self.file.current_path)
    self.screenshot = movie.screenshot("#{Rails.root}/public/uploads/tmp/screenshots/#{File.basename(self.file.path)}.jpg", seek_time: 2 )
  end
end