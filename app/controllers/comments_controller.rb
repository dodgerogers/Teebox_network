class CommentsController < ApplicationController
  
  before_filter :authenticate_user! 
  before_filter :load_commentable
  load_and_authorize_resource except: [:new, :index]
  include Teebox::Votable
  
  def create 
    @comment = @commentable.comments.build(params[:comment])
    @comment.user_id = current_user.id
    respond_to do |format|
    if @comment.save
      # comments can only be voted on and have no point value themselves, hence we don't create one
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