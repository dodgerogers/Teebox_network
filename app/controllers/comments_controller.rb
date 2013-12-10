class CommentsController < ApplicationController
  
  before_filter :authenticate_user! 
  before_filter :load_commentable
  load_and_authorize_resource except: [:new, :index]
  include Teebox::Votable
  
  def create 
    # current user build? as commentable is passed in to params
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
    if @comment.save
      @comment.create_activity :create, owner: current_user, recipient: @commentable.user unless current_user == @commentable.user
      format.html { redirect_to :back, notice: 'Comment created'}
      format.js
    else
      format.html { redirect_to :back, notice: "Content can't be blank" }
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