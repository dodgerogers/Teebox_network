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
    FFMPEG.ffmpeg_binary = '/opt/local/bin/ffmpeg'
    if self.file.include? "http://teebox-network.s3.amazonaws.com/"
      movie = FFMPEG::Movie.new(self.file)
      self.screenshot = movie.screenshot(location, seek_time: 1 )
      if self.save!
        File.delete(location)
      end
    else
      errors.add(:file, "Upload failed, please try again")
    end
  end
  
  def get_key(file)
    file.gsub('http://teebox-network.s3.amazonaws.com/', '')
  end
  
  def delete_key
    object = AWS::S3.new.buckets['teebox-network'].objects[get_key(self.file)]
    object.delete
    logger.debug "Video deleted: #{object}"
  end
  
  protected
  
  
  def log_level
    "-loglevel panic"
  end
  
  def unique
    (0..6).map{(65+rand(26)).chr}.join
  end
end