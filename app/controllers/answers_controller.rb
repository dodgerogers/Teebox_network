class AnswersController < ApplicationController
  
  before_filter :find_question, except: [:destroy]
  before_filter :authenticate_user!, except: [:index, :show]
  
  def find_question
    resource, id = request.path.split('/')[1,2]
    @question = resource.singularize.classify.constantize.find(id)
  end
  
  def new
    @answer = @question.answers.new
  end
  
  def show
    @answer = @question.answers.find(params[:id])
  end
  
  def index
    @answers = @question.answers.includes(:user)
  end
  
  def create
    @answer = @question.answers.build(params[:answer])
    respond_to do |format|
    if @answer.save
        format.html { redirect_to @question, notice: 'Answer created'}
        format.js
    else
        format.html {  redirect_to @question, notice: "Please try again" }
        format.js
      end
    end
  end
  
  def edit
    @answer = Answer.find(params[:id])
  end
  
  def update
    @answer = Answer.find(params[:id])
    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { render @question, notice: "Updated" }
        format.js 
      else
        format.html { render "edit", notice: "Plese try again" }
        format.js
      end
    end
  end
  
  def destroy
     @answer = Answer.destroy(params[:id])
        respond_to do |format|
          format.js
    end
  end
end