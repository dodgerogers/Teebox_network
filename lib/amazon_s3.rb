class AmazonS3
  
  # Rather than gsubbing the bucketname
  # split the string then rejoin because of fog using https and videos http
  def self.find_videos
    files = []
    Video.all.each do |v|
      files << v.file 
      files << v.screenshot
    end
    files.map {|file| file.split(/\//)[3..-1].join('/') }
  end

  def self.cleanup
    bucket = AWS::S3.new.buckets[CONFIG[:s3_bucket]].objects
    files = self.find_videos
    number_of_files = (bucket.map(&:key) - self.find_videos)
    if number_of_files.size > 0
      puts "Would you like to delete #{number_of_files.size} erroneous AWS::S3 objects?\n#{number_of_files}\n Answer y/n"
      if gets.chomp.downcase == "y"
        valid = bucket.map(&:key) & files
        bucket.each do |obj| 
          unless valid.include? obj.key
            puts "deleting #{obj.key}"
            obj.delete 
          end
        end
      else
        puts "Operation cancelled"
      end 
    else
       puts "No AWS::S3 objects to clean" 
    end
  end
end