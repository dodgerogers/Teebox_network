class VideosController < ApplicationController
  
  def show
    @video = Video.find(params[:id])
  end
  
  def index
    @video = Video.all
  end
  
  def new
    @video = Video.new
  end
  
  def edit
    @video = Video.find(params[:id])
  end
  
  def create
    @video = current_user.videos.build(params[:video])  
    if @video.save
      redirect_to @video, notice: "Saved successfully"
    else
      render :new
    end
  end
  
  def update
    @video = Video.find(params[:id])
  end
  
  def destroy
    @video = Video.find(params[:id])
  end
end