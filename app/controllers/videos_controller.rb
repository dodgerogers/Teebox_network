class VideosController < ApplicationController
  
  before_filter :authenticate_user!, except: [:show]
  
  
  def show
    @video = Video.find(params[:id])
  end
  
  def index
    @videos = current_user.videos
    @video = Video.new
  end
  
  def new
    @video = Video.new
  end
  
  def edit
    @video = Video.find(params[:id])
  end
  
  def create
    @video = Video.create(params[:video])
    respond_to do |format|
      if @video.save
        format.html { redirect_to videos_path, notice: 'Video was successfully uploaded.' }
        format.json { render json: @video, status: :created, location: @video }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update
    @video = Video.find(params[:id])
  end
  
  def destroy
    @video = Video.destroy(params[:id])
    respond_to do |format|
      format.html { redirect_to videos_path }
      format.js
    end
  end
end