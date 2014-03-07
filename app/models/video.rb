class Video < ActiveRecord::Base
  
  attr_accessible :file, :screenshot
  
  has_many :questions, through: :playlists
  has_many :playlists
  belongs_to :user
  
  validates_presence_of :user_id, :file
  
  default_scope order('created_at DESC')
  
  mount_uploader :screenshot, ScreenshotUploader
    
  def to_param
    "#{id} - #{File.basename(self.file)}".parameterize
  end
  
  def take_screenshot
    location = "#{Rails.root}/public/uploads/tmp/screenshots/#{unique}_#{File.basename(self.file)}.jpg"
    if self.file.include? "http://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/"
       self.screenshot = FFMPEG::Movie.new(self.file).screenshot(location, {seek_time: 1, resolution: "200x100"}, preserve_aspect_ratio: :width)
       File.delete(location) if self.save!
    end
  end
  
  def get_key(file)
    file.gsub("http://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/", '')
  end
  
  def delete_key
    object = AWS::S3.new.buckets[CONFIG[:s3_bucket]].objects[get_key(self.file)]
    object.delete
    logger.debug "Video deleted: #{object} #{self.attributes}"
  end
    
  def unique
    (0..6).map{(65+rand(26)).chr}.join
  end
end