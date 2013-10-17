require "spec_helper"

describe '404 not found' do
  it 'should respond with 404 page' do
    visit '/foo'
    page.should have_content('404 This is not the page you were looking for')
  end
end

describe "500 error" do  
  it "should respond with 500 page" do
    #response.status.should == 500
  end
end
    