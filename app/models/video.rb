class Video < ActiveRecord::Base
  
  attr_accessible :question_id, :file, :screenshot
  
  has_many :questions
  belongs_to :user
  
  validates_presence_of :user_id, :file
  
  default_scope order('created_at DESC')
  
  mount_uploader :screenshot, ImageUploader
  
  def to_param
    "#{id} - #{File.basename(self.file)}".parameterize
  end
  
  def take_screenshot
    location = "#{Rails.root}/public/uploads/tmp/screenshots/#{unique}_#{File.basename(file)}.jpg"
    FFMPEG.ffmpeg_binary = ENV["FFMPEG_LOCATION"]
    if self.file.include? "http://teebox-network.s3.amazonaws.com/"
      self.screenshot = FFMPEG::Movie.new(self.file).screenshot(location, seek_time: 2 )
      if self.save!
        File.delete(location)
      end
    else
      logger.debug("Upload failed")
    end
  end
  
  def get_key(file)
    file.gsub('http://teebox-network.s3.amazonaws.com/', '')
  end
  
  def delete_key
    object = AWS::S3.new.buckets['teebox-network'].objects[get_key(self.file)]
    object.delete
    logger.debug "Video deleted: #{object} #{self.attributes}"
  end
  
  protected
  
  def unique
    (0..6).map{(65+rand(26)).chr}.join
  end
end