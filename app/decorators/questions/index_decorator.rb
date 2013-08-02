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
  
  def current_page
    "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
  end
  
  def tag_class(tag)
    current_page == tagged_url(tag.name) ? "current_tag" : "tag" 
  end
  
  def tab_class(url)
    current_page == url ? "success" : "asphalt" 
  end

  def questions
    @questions.paginate(page: params[:page], per_page: 20).includes(:user, :video).search(params[:search])
  end

  def tags
    @tags.joins(:taggings).select('tags.*, count(tag_id) as "tag_count"').group(:tag_id).order(' tag_count desc')
  end

  def tagged_questions
    @questions.tagged_with(params[:tag]).paginate(page: params[:page], per_page: 20).includes(:user, :video)
  end

  def newest_questions
    @questions.newest.paginate(page: params[:page], per_page: 20).includes(:user, :video)
  end

  def unanswered_questions
    @questions.unanswered(params[:unanswered]).paginate(page: params[:page], per_page: 20).includes(:user, :video)
  end

  def votes_questions
    @questions.by_votes(params[:by_votes]).paginate(page: params[:page], per_page: 20).includes(:user, :video)
  end
end