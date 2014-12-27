class AnswersController < ApplicationController
  
  before_filter :authenticate_user!, except: [:show]
  load_and_authorize_resource
  require 'teebox/commentable'
  include Teebox::Commentable
  
  def show
  end
  
  def create
    @answer = current_user.answers.build(params[:answer])
    respond_to do |format|
      if @answer.save
        Teebox::Pointable.create(@answer.user, @answer)
        @answer.create_activity :create, owner: current_user, recipient: @answer.question.user unless current_user == @answer.question.user
        format.html { redirect_to @answer.question, notice: 'Answer created'}
        format.js
      else
        format.html {  redirect_to :back, notice: "Please try again" }
        format.js
      end
    end
  end
  
  def edit
  end
  
  def update
    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to :back, notice: "Updated" }
        format.js 
        format.json { head :ok}
      else
        format.html { render "edit", notice: "Plese try again" }
        format.js
      end
    end
  end
  
  def destroy
     @answer = Answer.find(params[:id])
     @answer.destroy
     respond_to do |format|
       format.js
     end
  end
  
  def correct 
    @answer = AnswerRepository.toggle(params) 
    if @answer
      respond_to do |format|
        format.html { redirect_to @answer.question, notice: "Successful" }
        format.js
      end
    end
  end
end