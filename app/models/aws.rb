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

   def self.aws_cleanup
     bucket = AWS::S3.new.buckets['teebox-network'].objects
     files = self.get_screenshots.zip(self.get_videos).flatten.compact
     if (bucket.map(&:key) - files).size > 0
       valid = bucket.map(&:key) & files
       bucket.each do |obj|
         obj.delete unless valid.include? obj.key
       end  
       else
        "No objects to delete" 
     end
   end
end