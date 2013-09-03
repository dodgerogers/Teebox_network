class Aws < Video
  
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

   def self.cleanup
     bucket = AWS::S3.new.buckets['teebox-network'].objects
     files = self.get_screenshots.zip(self.get_videos).flatten.compact
     number_of_files = (bucket.map(&:key) - files)
     if number_of_files.size > 0
        p "Deleting #{number_of_files.size} AWS::S3 objects"
        valid = bucket.map(&:key) & files
        bucket.each { |obj| obj.delete unless valid.include? obj.key } 
     else
       "No AWS::S3 objects to clean" 
     end
   end
end