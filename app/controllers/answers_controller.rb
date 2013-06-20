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
     @answer = Answer.destroy(params[:id])
      respond_to do |format|
        format.js
    end
  end
  
  def vote 
    @vote = current_user.votes.build(value: params[:value], votable_id: params[:id], votable_type: "Answer")
    respond_to do |format|
    if @vote.save
      format.html { redirect_to :back, notice: "Vote submitted" }
      format.js
    else
      format.html { redirect_to :back, alert: "You can't vote on your own content" }
      format.js
    end
  end
  end
  
  def correct 
    @answer = Answer.find(params[:id])
    if @answer.toggle_correct(:correct)
       @answer.toggle_question_correct
       @answer.add_reputation
        respond_to do |format|
          format.html { redirect_to :back, notice: "Answer submitted" }
          format.js
      end
    end
  end
end