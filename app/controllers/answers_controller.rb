class AnswersController < ApplicationController
  
  before_filter :authenticate_user!, except: [:index, :show]
  
  
  def create
    @answer = current_user.answers.build(params[:answer])
    respond_to do |format|
    if @answer.save
        format.html { redirect_to :back, notice: 'Answer created'}
        format.js
    else
        format.html {  redirect_to :back, notice: "Please try again" }
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