class TagsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def new
    @tag = Tag.new
  end
  
  def show
    @tag = Tag.find(params[:id])
  end
  
  def index
    @tag = Tag.new
    @tags = Tag.order("created_at DESC").paginate(page: params[:page], per_page: 5).search(params[:search])
  end
  
  def create
    @tag = Tag.create(params[:tag])
    respond_to do |format|
      if @tag.save
        format.html { redirect_to @tag, notice: "Tag created" }
      else
      format.html { redirect_to tags_path, notice: "Try again" }
      end
    end
  end
  
  def update
    @tag = Tag.find(params[:id])
    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        format.html { redirect_to @tag, notice: "Successfully updated" }
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
  
  def question_tags
    @tags = Tag.order(:name)
    respond_to do |format|
      format.json { render json: @tags.tokens(params[:q]) }
    end
  end
end
