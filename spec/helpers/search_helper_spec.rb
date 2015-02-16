require 'spec_helper'

describe SearchHelper do
  before(:each) do
    @articles = 2.times.map { create(:article) }.paginate
    @questions = 2.times.map { create(:question) }.paginate
    @users = 2.times.map { create(:user) }.paginate
    helper.stub(:render).and_return("<div></div>".html_safe)
    
    @results = { articles: @articles, questions: @questions, users: @users}
  end
  
  describe 'render_search_results' do
    it 'renders html when results present' do
      html = helper.render_search_results(@results, total: 6, text: 'search term')
      
      html.should have_selector('.questions-index')
      html.should have_selector('.articles-index')
      html.should have_selector('.users-index')
      
      html.should include('Search Results for')
    end
    
    it 'displays nothing found text for no results' do
      html = helper.render_search_results([], total: 0, text: 'nothing found for this term')
      
      html.should_not have_selector('.questions-index')
      html.should_not have_selector('.articles-index')
      html.should_not have_selector('.users-index')
      
      html.should include('Nothing found')
    end
  end
end