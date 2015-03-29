class QuestionsController < ApplicationController
  include Teebox::Commentable
  
  before_filter :authenticate_user!, except: [:index, :show, :popular, :unanswered, :related]
  before_filter :set_question, only: [:show, :related]
  before_filter :set_articles, only: [:show, :index]
  load_and_authorize_resource except: [:index, :show, :related]
  
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
    @answer = Answer.new
    @answers = @decorator.answers.includes(:user, :question).by_votes
    ImpressionRepository.create(@decorator, request)
  end
  
  def create
    @question = current_user.questions.build(params[:question])
    if @question.save
      PointRepository.create(@question.user, @question)
      NotificationMailer.delay.new_question_email(@question)
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
    @unanswered = Question.unanswered.includes(:user, :videos).paginate(page: params[:page], per_page: 20)
  end

  def popular
    @popular = Question.popular.includes(:user, :videos).paginate(page: params[:page], per_page: 20)
  end
  
  def related
    @related = @decorator.related_questions 
    respond_to do |format|
      format.html { render layout: false }
    end
  end
  
  private
  
  def set_question
    question = Question.find(params[:id])
    @decorator ||= Questions::ShowDecorator.new(question)
  end
  
  def set_articles
    @articles = Article.state(Article::PUBLISHED).order('published_at DESC').sample(2)
  end
end