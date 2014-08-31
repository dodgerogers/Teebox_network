class TranscoderRepository < BaseRepository
  
  ERROR_MSG_GENERIC = "TranscoderRepository error: %s"
  AWS_REGION = "us-east-1"
  MP4_PRESET = "1395783135978-fq7lgp"
  
  def initialize(video)
    raise ArgumentError, sprintf(ERROR_MSG_GENERIC, "not a valid video object") unless video.is_a?(Video)
    
    @video = video
    @filename = File.basename(@video.file, File.extname(@video.file))
  end
  
  def create
    transcoder = AWS::ElasticTranscoder::Client.new(region: AWS_REGION)
    options = {
      pipeline_id: CONFIG[:aws_pipeline_id],
      input: { 
        key: @video.file.split("/")[3..-1].join("/"),
        frame_rate: "auto", 
        resolution: 'auto', 
        aspect_ratio: 'auto', 
        interlaced: 'auto', 
        container: 'auto' 
        },
      outputs: [
        {
          key: "#{@filename}-1.mp4",
          preset_id: MP4_PRESET, 
          rotate: "auto", 
          thumbnail_pattern: "#{@filename}-{count}"
        }
      ],
      output_key_prefix: "#{@video.file.split("/")[3..5].join("/")}/"
    }
    job = transcoder.create_job(options)
    @video.update_attributes(job_id: job.data[:job][:id], status: job.data[:job][:status])
  end
end