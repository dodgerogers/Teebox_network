class CommentsController < ApplicationController
  
  before_filter :load_commentable
  
  def new
    @comment = @commentable.comments.new
  end

  def show
    @comment = Comment.find(params[:id])
  end
  
  def index
    @comments = @commentable.comments
  end
  
  def create 
    @comments = @commentable.comments
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @commentable, notice: 'Comment created'}
        format.js
      end
    else
      render :new
    end
  end
  
  def destroy
     @comment = Comment.destroy(params[:id])
        respond_to do |format|
          format.js
          end
       end
  
  private
  
  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end