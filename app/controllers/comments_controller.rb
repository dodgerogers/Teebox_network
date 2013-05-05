class CommentsController < ApplicationController
  
  before_filter :load_commentable
  
  def new
    @comment = @commentable.comments.new
  end
  
  def create 
    @comment = @commentable.comments.build(params[:comment])
    if @comment.save
      redirect_to @commentable, notice: 'Comment created'
    else
      render :new
    end
  end
  
  def destroy
     @comment = Comment.destroy(params[:id])
        respond_to do |format|
          format.js
          format.html { redirect_to @commentable }
          end
       end
  
  private
  
  def load_commentable
    resource, id = request.path.split('/')[1,2]
    @commentable = resource.singularize.classify.constantize.find(id)
  end
end