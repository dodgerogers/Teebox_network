class CommentsController < ApplicationController
  
  before_filter :load_commentable
  
  def new
    @comment = @commentable.comments.new
  end

  def show
    @comment = @commentable.comments.find(params[:id])
  end
  
  def index
    @comments = @commentable.comments.includes(:user)
  end
  
  def create 
    @comments = @commentable.comments
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
    if @comment.save
        format.html { redirect_to @commentable, notice: 'Comment created'}
        format.js
    else
      format.html { redirect_to @commentable, notice: "Content can't be blank" }
      format.js
      end
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