class Transcoder
  def initialize(video)
    @video = video
    @filename = File.basename(@video.file, File.extname(@video.file))
  end
  
  def create
    transcoder = AWS::ElasticTranscoder::Client.new(region: "us-east-1")
    options = {
      pipeline_id: CONFIG[:aws_pipeline_id],
      input: { 
        key: @video.file.split("/")[3..-1].join("/"), # Trim the file url to uploads/video/SecureRandom.hex/file.mp4 
        frame_rate: "auto", 
        resolution: 'auto', 
        aspect_ratio: 'auto', 
        interlaced: 'auto', 
        container: 'auto' 
        },
      outputs: [
        {
          key: "#{@filename}-1.mp4", # One added to avoid duplicates in .mp4 filenames
          preset_id: '1395783135978-fq7lgp', # Generic mp4'1351620000001-000020', 
          rotate: "auto", 
          thumbnail_pattern: "#{@filename}-{count}"
        }
      ],
      output_key_prefix: "#{@video.file.split("/")[3..5].join("/")}/" # => Trims the path to uploads/video/SecureRandom.hex
    }
    job = transcoder.create_job(options)
    @video.update_attributes(job_id: job.data[:job][:id], status: job.data[:job][:status])
  end
end