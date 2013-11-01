class VideosController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @video = Video.find(params[:id])
  end
  
  def index
    @videos = Video.where(user_id: current_user.id).all
    respond_to do |format|
      format.html { @videos }
      format.json { render json: @videos }
    end
    @video = Video.new
  end
  
  def new
    @video = Video.new
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