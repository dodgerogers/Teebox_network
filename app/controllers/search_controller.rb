class SearchController < ApplicationController
  
  def index
    result = GlobalSearch.call(search_params)
    if result.success?
      @results = result.collection
      @total = result.total
    else
      redirect_to root_path, notice: result.message
    end
  end
  
  private
  
  def search_params
    params.slice(:search, *GlobalSearch::PAGE_PARAMS)
  end
end