require 'file_size_validator'

class Video < ActiveRecord::Base
  
  attr_accessible :user_id, :question_id, :file, :screenshot
  belongs_to :question
  belongs_to :user
  
  default_scope order('created_at DESC')
  
  #after_commit :take_screenshot
  
  #mount_uploader :screenshot, ImageUploader
  
  #validates :file, presence: true, file_size: { maximum: 5.megabytes.to_i }
  validates_presence_of :user_id, :file
    
  def to_param
    "#{id} - #{File.basename(self.file)}".parameterize
  end
  
  def take_screenshot
    logger.debug "Trying to grab a screenshot from #{self.file}"
    #movie = FFMPEG::Movie.new(self.file)
    #self.screenshot = movie.screenshot(self.file, seek_time: 2)
    system "ffmpeg -i #{self.file} -ss 00:00:02 -vframes 1 #{Rails.root}/public/uploads/tmp/screenshots/#{File.basename(self.file)}.jpg"
  end
  
  def get_key(file)
    file.gsub('http://teebox-network.s3.amazonaws.com/', '')
  end
  
  def delete_key
    object = AWS::S3.new.buckets['teebox-network'].objects[get_key(self.file)]
    video_url = object.url_for(:delete)
  end
end