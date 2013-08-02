class ReportsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @all_reports = Report.all
    @reports = @all_reports.paginate(page: params[:page], per_page: 3)
    @report = Report.new
  end
  
  def create
    @report = Report.new(params[:report])
    respond_to do |format|
      if @report.save
        format.html { redirect_to reports_path, notice: "Report Created" }
      else
        format.html { redirect_to reports_path, notice: "Report generation failed" }
      end
    end
  end 
  
  def destroy
    @report = Report.destroy(params[:id])
    if @report.destroy
     redirect_to reports_path, notice: "Report deleted"
    else
     redirect_to reports_path, notice: "Delete failed, please try again"
   end
  end
end