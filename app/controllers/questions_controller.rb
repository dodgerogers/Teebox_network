class QuestionsController < ApplicationController
  
  before_filter :authenticate_user!, except: [:index, :show]
  caches_page :index
    
  def show
    @question = Question.find(params[:id])
    @commentable = @question
    @comments = @commentable.comments.includes(:user)
    @comment = Comment.new
    @answer = Answer.new
    @answers = @question.answers.includes(:user).by_votes
  end
  
  def new
    @question = Question.new
  end
  
  def index
    @presenter = Questions::IndexPresenter.new(params)
    #if params[:tag]
    #  @questions ||= @question.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 20)
    #elsif params[:search]
    #  @questions ||= @question.paginate(page: params[:page], per_page: 20).search(params[:search])
    #else
    #  @questions.newest.paginate(page: params[:page], per_page: 2)
    #  @unanswered ||= @question.unanswered.paginate(page: params[:page], per_page: 2).search(params[:search])
    #  @votes ||= @question.by_votes.paginate(page: params[:page], per_page: 2).search(params[:search])
  end
  
  def create
    @question = current_user.questions.build(params[:question])
    if @question.save
      redirect_to @question, notice: "Question Created"
    else
      render :new, notice: "Please try again"
    end
  end
  
  def edit
    @question = Question.find(params[:id])
  end
  
  def update 
    @question = Question.find(params[:id])
    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to @question, notice: "Successfully updated" }
        format.json { head :no_content }
      else
        format.html { render "edit", notice: "Plese try again" }
        format.json { render json: @question.errors, status: :unprocessable_entity  }
      end
    end
  end
  
  def destroy
    @question = Question.destroy(params[:id])
    if @question.destroy
     redirect_to home_path, notice: "Question deleted"
   else
     redirect_to @question, notice: "Delete failed, please try again"
   end
  end
  
  def vote
    @vote = current_user.votes.build(value: params[:value], votable_id: params[:id], votable_type: "Question")
    respond_to do |format|
    if @vote.save
      format.html {redirect_to :back, notice: "Vote submitted"}
      format.js
    else
      format.html {redirect_to :back, alert: "You can't vote on your own content"}
      format.js
      end
    end
  end
end