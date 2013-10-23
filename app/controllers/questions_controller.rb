class QuestionsController < ApplicationController
  
  before_filter :authenticate_user!, except: [:index, :show, :highest_votes, :unanswered]
  before_filter :index, only: [:unanswered, :highest_votes]
  load_and_authorize_resource except: [:index, :show]
  require 'teebox/commentable'
  include Teebox::Commentable
  
  def new
    @question = Question.new
  end
  
  def index
    @decorator = Questions::IndexDecorator.new(params)
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.includes(:question, :user).by_votes
    @decorator = Questions::ShowDecorator.new(@question)
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
     redirect_to root_path, notice: "Question deleted"
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