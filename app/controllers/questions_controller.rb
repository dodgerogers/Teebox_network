class QuestionsController < ApplicationController
  
  before_filter :authenticate_user!, except: [:index, :show, :popular, :unanswered]
  load_and_authorize_resource except: [:index, :show]
  require 'teebox/commentable'
  include Teebox::Commentable
  include Teebox::Votable
  
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
    question = Question.find(params[:id])
    @answer = Answer.new
    @decorator = Questions::ShowDecorator.new(question)
    @answers = @decorator.answers.includes(:question, :user).by_votes
  end
  
  def create
    @question = current_user.questions.build(params[:question])
    if @question.save
      Teebox::Pointable.create_point(@question.user, @question)
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
    end
  end
  
  def unanswered
    @unanswered = Question.unanswered.includes(:user, :video).paginate(page: params[:page], per_page: 20)
  end

  def popular
    @popular = Question.popular.includes(:user, :video).paginate(page: params[:page], per_page: 20)
  end
end