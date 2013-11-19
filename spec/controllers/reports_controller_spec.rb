require "spec_helper"

describe ReportsController do
  before(:each) do
    @report = create(:report)
    @user1 = create(:user)
    @user1.confirm!
    sign_in @user1
  end
  
  describe "GET index" do
    it "renders index template" do
      get :index
      response.should render_template :index
    end
  end
  
  describe "all_reports" do
    it "retrieves stats" do
      controller.all_reports.should eq([@report])
    end
  end
  
  describe "stats" do
    it "render stats partial" do
      get :stats
      response.should render_template :stats
    end
  end
  
  describe "POST create" do
    describe "with valid params" do
      it "creates a new report" do
        expect {
          post :create, report: attributes_for(:report)
        }.to change(Report, :count).by(1)
      end

      it "assigns a newly created report as @report" do
        post :create, report: attributes_for(:report)
        assigns(:report).should be_a(Report)
        assigns(:report).should be_persisted
      end

      it "redirects to the report index" do
        post :create, report: attributes_for(:report)
        response.should redirect_to reports_path
      end
    end
    
    describe "with invalid params" do
      it "redirects to reports index" do
        Report.any_instance.stub(:save).and_return(false)
        post :create, report: attributes_for(:report)
        response.should redirect_to reports_path
      end
    end
  end
  
  describe "DELETE destroy" do    
    it "destroys the requested video" do
      expect {
        delete :destroy, id: @report
      }.to change(Report, :count).by(-1)
    end

    it "redirects to the posts list" do
      delete :destroy, id: @report
      response.should redirect_to stats_reports_path
    end
  end
end