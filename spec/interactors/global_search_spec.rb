require 'spec_helper'

describe GlobalSearch do
  before(:each) do
    @user = create(:user)
    @article1 = create(:article, user: @user, title: "Driver article")
    @article2 = create(:article, user: @user, title: "Putting article")
    @article3 = create(:article, user: @user, title: "Chipping article")
    
    @question1 = create(:question, user: @user, title: "How do i improve my driver")
    @question2 = create(:question, user: @user, title: "How do i improve my chipping")
    @question3 = create(:question, user: @user, title: "Tiger woods through the years")
  end
  
  describe '#call' do
    context 'valid params' do
      it 'returns an empty hash when no matching results' do
        result = GlobalSearch.call(search: 'short game')
        
        result.collection[:articles].should eq []
        result.collection[:questions].should eq []
        result.total.should eq 0
      end
      
      it 'returns matching questions and articles' do
        result = GlobalSearch.call(search: 'driver')
        
        result.collection[:articles].should include(@article1)
        result.collection[:questions].should include(@question1)
        result.total.should eq 2
      end
      
      it 'only returns matching questions' do
        result = GlobalSearch.call(search: 'tiger')
        
        result.collection[:articles].should eq []
        result.collection[:questions].should include(@question3)
        result.total.should eq 1
      end
    end
    
    context 'invalid params' do
      it 'fails with invalid query params' do
        result = GlobalSearch.call(search: Struct.new(:name))
        
        result.success?.should be_false
        result.error.should include(GlobalSearch::SEARCH_PARAMS_ERROR)
      end
    end
  end
end