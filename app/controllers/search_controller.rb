class SearchController < ApplicationController
  before_filter :set_articles
  
  def index
    result = GlobalSearch.call(search_params)
    if result.success?
      @result = result
    else
      redirect_to root_path, notice: result.message
    end
  end
  
  private
  
  def search_params
    params.slice(:search, *GlobalSearch::PAGE_PARAMS)
  end
  
  def set_articles
    @articles = Article.state(Article::PUBLISHED).order('published_at DESC').sample(2)
  end
end