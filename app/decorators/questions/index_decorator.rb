class Questions::IndexDecorator < ApplicationDecorator
  delegate_all
  decorate :question
  include Draper::LazyHelpers
  
  def initialize(params = {})
     @params = params
   end
  
  def params
    @params
  end

  def search
    @search ||= Question.text_search(params[:search]).includes(:user, :video).paginate(page: params[:page], per_page: 20)
  end

  def tags
    Tag.joins(:taggings).select('tags.*, count(tag_id) as "tag_count"').group("tags.id").order('tag_count desc')
  end

  def tagged_questions
    @tagged ||= Question.tagged_with(params[:tag]).includes(:user, :video).paginate(page: params[:page], per_page: 20)
  end

  def newest_questions
    @newest ||= Question.newest.includes(:user, :video).paginate(page: params[:page], per_page: 20)
  end
end