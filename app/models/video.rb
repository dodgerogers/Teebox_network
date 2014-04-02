class Video < ActiveRecord::Base
  
  attr_accessible :file, :screenshot, :job_id, :status
  
  has_many :questions, through: :playlists
  has_many :playlists
  belongs_to :user
  
  validates_presence_of :user_id, :file
  
  default_scope order('created_at DESC')
    
  def to_param
    "#{id} - #{File.basename(self.file)}".parameterize
  end
  
  def self.retrieve_payload(notification)
    # parse the javascript and fetch the ENV bucket
    message = JSON.parse(notification["Message"])
    bucket = "http://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/#{message["outputKeyPrefix"]}"
    
    # Fetch the video by the job id
    video = self.where(job_id: message["jobId"])[0]
    
    # If the job completed successfully we'll save the json response to the db otherwise we'll notify the user it failed
    if message["state"] == "COMPLETED"
      
      # Delete the original video on S3
      AWS::S3.new.buckets[CONFIG[:s3_bucket]].objects[video.get_key].delete
      
      # Update the screenshot, file and status from the JSOn response
      video.update_attributes(
        file: "#{bucket}#{message["outputs"][0]["key"]}", 
        screenshot: "#{bucket}#{message["outputs"][0]["thumbnailPattern"]}".gsub!('-{count}', '-00001.jpg'),
        status: message["state"]
      )
    else
      # Save the status when something goes wrong
      video.update_attributes(status: message["state"])
    end
  end
  
  def get_key(attribute=:file)
    self.send(attribute).gsub("http://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/", '') if self.send(attribute)
  end
  
  def delete_key
    # Split "http://aws-bucket.s3.amazonaws.com/uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947/IMG_0587.mp4" 
    # into "uploads/video/ca14ba7a-c442-4f9f-a75a-c45cfedb8947" 
    folder = File.split(self.file)[0].split("/")[3..-1].join("/")
    AWS::S3.new.buckets[CONFIG[:s3_bucket]].objects.with_prefix(folder).delete_all
  end
end