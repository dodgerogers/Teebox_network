class Video < ActiveRecord::Base
  
  attr_accessible :question_id, :file, :screenshot, :user_id
  has_many :questions
  belongs_to :user
  
  default_scope order('created_at DESC')
  
  #after_commit :take_screenshot
  
  mount_uploader :screenshot, ImageUploader
  
  validates_presence_of :user_id, :file
    
  def to_param
    "#{id} - #{File.basename(self.file)}".parameterize
  end
  
  def take_screenshot
    logger.debug "Trying to grab a screenshot from #{self.file}"
    #self.screenshot =   `ffmpeg -i #{self.file} -ss 00:00:02 -c:v mjpeg -f mjpeg -vframes 1 - 2>/dev/null `
    #self.screenshot = `ffmpeg -i #{self.file} -ss 00:00:02 -vframes 1 #{Rails.root}/public/uploads/tmp/screenshots/#{File.basename(self.file)}.jpg`
    FFMPEG.ffmpeg_binary = '/opt/local/bin/ffmpeg'
    movie = FFMPEG::Movie.new(self.file)
    self.screenshot = movie.screenshot("#{Rails.root}/public/uploads/tmp/screenshots/#{File.basename(self.file.path)}.jpg", seek_time: 2 )
  end
  
  def get_key(file)
    file.gsub('http://teebox-network.s3.amazonaws.com/', '')
  end
  
  def delete_key
    object = AWS::S3.new.buckets['teebox-network'].objects[get_key(self.file)]
    object.delete
    logger.debug "Video deleted: #{object}"
  end
end