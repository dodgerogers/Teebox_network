class VideosController < ApplicationController
  
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def show
  end
  
  def index
    @videos = current_user.videos.where("id > ?", params[:after].to_i)
    @video = Video.new
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new   
  end
  
  def create
    @video = current_user.videos.build(params[:video])
    respond_to do |format|
      if @video.save
        Rails.logger.info("**********\nSaving video #{@video.id} #{@video.attributes}\n")
        transcoder = TranscoderRepository.generate(@video)
        format.html { redirect_to videos_path, notice: 'Video was successfully uploaded.' }
        format.js 
      else
        format.html { render action: "new" }
      end
    end
  end
  
  def destroy
    @video = Video.destroy(params[:id])
    if @video.destroy
      @video.delete_aws_key
      respond_to do |format|
        format.html { redirect_to videos_path, notice: "Video deleted" }
        format.js
      end
    end
  end
end