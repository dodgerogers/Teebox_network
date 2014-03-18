class VideosController < ApplicationController
  
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def show
  end
  
  def index
    @videos = current_user.videos
    @video = Video.new
  end
  
  def new   
  end
  
  def create
    @video = current_user.videos.build(params[:video])
    respond_to do |format|
      if @video.save
        @video.delay.take_screenshot
        format.html { redirect_to videos_path, notice: 'Video was successfully uploaded.' }
        format.json { render json: @video, status: :created, location: @video }
        format.js 
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @video = Video.destroy(params[:id])
    if @video.destroy
      @video.delete_key
      respond_to do |format|
        format.html { redirect_to videos_path, notice: "Video deleted" }
        format.js
      end
    end
  end
end