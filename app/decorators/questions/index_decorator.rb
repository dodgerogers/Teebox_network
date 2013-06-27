class Questions::IndexDecorator < ApplicationDecorator
  delegate_all
  decorate :question
  include Draper::LazyHelpers
  
  def initialize(params = {})
     @questions = Question
     @tags = Tag
     @params = params
   end
  
  def params
    @params
  end
  
  def tag_class(tag)
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}" == tagged_url(tag.name) ? "current_tag" : "tag" 
  end
  
  def tab_class(url)
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}" == url ? "tab active" : "tab" 
  end

  def questions
    @questions.paginate(page: params[:page], per_page: 20).search(params[:search])
  end

  def tags
    @tags.joins(:taggings).select('tags.*, count(tag_id) as "tag_count"').group(:tag_id).order(' tag_count desc')
  end

  def tagged_questions
    @questions.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 20).includes(:user)
  end

  def newest_questions
    @questions.newest.paginate(page: params[:page], per_page: 20).includes(:user)
  end

  def unanswered_questions
    @questions.unanswered(params[:unanswered]).paginate(page: params[:page], per_page: 20).includes(:user)
  end

  def votes_questions
    @questions.by_votes(params[:by_votes]).paginate(page: params[:page], per_page: 20).includes(:user)
  end
end