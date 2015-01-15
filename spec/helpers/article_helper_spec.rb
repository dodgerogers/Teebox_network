require 'spec_helper'

describe ArticleHelper do
  before(:each) do
    @user = create(:user)
    @article = create(:article, user: @user)
    helper.stub(:can?).and_return(true)
  end
  
  describe 'valid_transition_links' do
    context 'with permission' do
      it 'renders submit and discard buttons' do
        helper.valid_transition_links(@article).should include('submit', 'discard')
      end
      
      it 'renders submit and discard with custom separator' do
        helper.valid_transition_links(@article, separator: 'custom_separator').should include('submit', 'discard', 'custom_separator')
      end
    end
  end
  
  describe 'article_status_bar' do
    it 'displays draft status and updated_at' do
      helper.article_status_bar(@article).should include(Article::DRAFT.capitalize, @article.updated_at.strftime('%b %d, %Y'))
    end
    
    it 'displays published status and updated_at' do
      article = create(:article, state: Article::PUBLISHED, published_at: Date.today)
      helper.article_status_bar(article).should include(Article::PUBLISHED.capitalize, article.published_at.strftime('%b %d, %Y'))
    end
  end
  
  describe 'article_cover_image' do
    it 'returns concatenated css style string' do
      helper.article_cover_image(@article.cover_image).should include(@article.cover_image)
    end
  end
end
  