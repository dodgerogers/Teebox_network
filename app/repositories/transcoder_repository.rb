class TranscoderRepository < BaseRepository
  
  ERROR_MSG_GENERIC = "TranscoderRepository error: %s"
  AWS_REGION = "us-east-1"
  MP4_PRESET = "1395783135978-fq7lgp"
  
  def self.generate(video)
    raise ArgumentError, sprintf(ERROR_MSG_GENERIC, "not a valid video object") unless video.is_a?(Video)
    
    if video
      Rails.logger.info("*~*~*~*~* Transcoder#generate starting...\n")
      options_hash = self.options(video)
      job_attributes_hash = self.create_transcoder_job(options_hash)
      video.update_attributes(job_attributes_hash)
      Rails.logger.info("*~*~*~*~* Transcoder#generate finishing...\n")
    end
  end
  
  def self.options(video)
    Rails.logger.info("*~*~*~*~* Transcoder#options...\n")
    filename = File.basename(video.file, File.extname(video.file))
    key = video.file.split("/")
    
    options = {
      pipeline_id: CONFIG[:aws_pipeline_id],
      input: { 
        key: key[3..-1].join("/"),
        frame_rate: "auto", 
        resolution: 'auto', 
        aspect_ratio: 'auto', 
        interlaced: 'auto', 
        container: 'auto' 
      },
      outputs: [
        {
          key: "#{filename}-1.mp4",
          preset_id: MP4_PRESET, 
          rotate: "auto", 
          thumbnail_pattern: "#{filename}-{count}"
        }
      ],
      output_key_prefix: "#{key[3..5].join("/")}/"
    }
  end
  
  
  def self.create_transcoder_job(options)
    raise ArgumentError, sprintf(ERROR_MSG_GENERIC, "must be a valid options hash") unless options.is_a?(Hash)
    
    Rails.logger.info("*~*~*~*~* Transcoder#create_transcoder_job started...\n")
    
    transcoder = AWS::ElasticTranscoder::Client.new(
      access_key_id: CONFIG[:aws_access_key_id],
  		secret_access_key: CONFIG[:aws_secret_key_id],
      region: AWS_REGION
      )
      
    job = transcoder.create_job(options)
    Rails.logger.info("*~*~*~*~* Transcoder#create_transcoder_job finished...\n")
    
    attributes = {}
    attributes.merge(job_id: job.data[:job][:id], status: job.data[:job][:status]) if job
  end
end