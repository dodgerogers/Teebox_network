class TagsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @tags = Tag.order("updated_at").paginate(page: params[:page], per_page: 50).reverse#.search(params[:search])
    @tag = Tag.new
  end
  
  def new
    @tag = Tag.new
  end
  
  def show
    @tag = Tag.find(params[:id])
  end
  
  def create
    @tag = current_user.tags.build(params[:tag])
    respond_to do |format|
      if @tag.save
        format.html { redirect_to tags_path, notice: "Tag created" }
      else
      format.html { redirect_to tags_path, notice: "Try again" }
      end
    end
  end
  
  def update
    @tag = Tag.find(params[:id])
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to tags_path, notice: "Successfully updated" }
        format.json { head :no_content }
      else
        format.html { render "edit", notice: "Plese try again" }
        format.json { render json: @tag.errors, status: :unprocessable_entity  }
      end
    end
  end
  
  def edit
    @tag = Tag.find(params[:id])
  end
  
  def destroy
    @tag = Tag.find(params[:id]).destroy
    redirect_to tags_path
  end
end
