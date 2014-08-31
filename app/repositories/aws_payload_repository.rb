class AwsVideoPayloadRepository < BaseRepository
  
  ERROR_MSG_GENERIC = "GeneratePointsRepo error: %s"
  JPEG_PREFIX = '-00001.jpg'
  COMPLETED_STATUS = "COMPLETED"
  ERR_STATUS = "ERROR"
  AWS_BUCKET_URL = "http://#{CONFIG[:s3_bucket]}.s3.amazonaws.com/"
  
  def self.retrieve_payload(notification)
    raise ArgumentError, sprintf(ERROR_MSG_GENERIC, "payload must be a valid hash") unless notification.is_a? Hash

    message = notification[:Message]
    
    bucket = AWS_BUCKET_URL + message[:outputKeyPrefix]
    attributes = { job_id: message[:jobId], status: message[:state] }
    
    if message[:state] == COMPLETED_STATUS
      file = (bucket + message[:outputs][0][:key])
      screenshot = (bucket + message[:outputs][0][:thumbnailPattern]).gsub!('-{count}', JPEG_PREFIX)
      
      attributes.merge!(file: file, screenshot: screenshot)
    end
    return attributes
  end
end