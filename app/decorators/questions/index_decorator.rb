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
    current_page == url ? "submit" : "asphalt" 
  end

  def questions
    @questions.includes(:user, :video).search(params[:search]).paginate(page: params[:page], per_page: 20)
  end

  def tags
    @tags.joins(:taggings).select('tags.*, count(tag_id) as "tag_count"').group("tags.id").order('tag_count desc')
    #@tags.find_by_sql(%Q{ select tags.name as tag_name, count(*) as "tag_count"
                          #from tags
                          #inner join taggings on taggings.tag_id = tags.id
                          #group by tags.name
                          #order by tag_count desc })
  end

  def tagged_questions
    @questions.tagged_with(params[:tag]).includes(:user, :video).paginate(page: params[:page], per_page: 20)
  end

  def newest_questions
    @questions.newest.includes(:user, :video).paginate(page: params[:page], per_page: 20)
  end

  def unanswered_questions
    @questions.unanswered(params[:unanswered]).includes(:user, :video).paginate(page: params[:page], per_page: 20)
  end

  def votes_questions
    @questions.by_votes(params[:by_votes]).includes(:user, :video).paginate(page: params[:page], per_page: 20)
  end
end