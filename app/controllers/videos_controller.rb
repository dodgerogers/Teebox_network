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
  end
  
  def update
    @video = Video.find(params[:id])
  end
  
  def destroy
    @video = Video.find(params[:id])
    @video.destroy
    redirect_to videos_path
  end
end