class Video < ActiveRecord::Base
  
  attr_accessible :question_id, :file, :screenshot
  
  has_many :questions
  belongs_to :user
  
  validates_presence_of :user_id, :file
  
  default_scope order('created_at DESC')
  
  mount_uploader :screenshot, ScreenshotUploader
    
  
  def to_param
    "#{id} - #{File.basename(self.file)}".parameterize
  end
  
  def take_screenshot
    location = "#{Rails.root}/public/uploads/tmp/screenshots/#{unique}_#{File.basename(file)}.jpg"
    FFMPEG.ffmpeg_binary = ENV["FFMPEG_LOCATION"]
    if self.file.include? "http://teebox-network.s3.amazonaws.com/"
       self.screenshot = FFMPEG::Movie.new(self.file).screenshot(location, seek_time: 1)
       File.delete(location) if self.save!
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
    
  def unique
    (0..6).map{(65+rand(26)).chr}.join
  end
  
  private
  
  def self.get_screenshots
    screenshots = Video.all.map(&:screenshot).map {|file| file.to_s.gsub!("https://teebox-network.s3.amazonaws.com/", "") }
    files = []
    screenshots.each do |object| 
      ar = File.split(object)
      ar[-1] = ar[-1].prepend("mini_")
      files << File.join(*ar)
    end
    screenshots.zip(files).flatten.compact
  end
  
  def self.get_videos
    Video.all.map(&:file).each {|file| file.gsub!("http://teebox-network.s3.amazonaws.com/", "") }
  end
    
  def self.aws_cleanup
    bucket = AWS::S3.new.buckets['teebox-network']
    valid = bucket.objects.map(&:key) & self.get_screenshots.zip(self.get_videos).flatten.compact
    bucket.objects.each do |obj|
      obj.delete unless valid.include? obj.key
    end   
  end
end