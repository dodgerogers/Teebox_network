class ReportsController < ApplicationController
  before_filter :authenticate_user! 
  before_filter :all_reports
  load_and_authorize_resource
  
  def all_reports
    @all_reports = Report.order("created_at")
    @reports = Report.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end
  
  def index
    @report = Report.new
  end
  
  def stats
  end
  
  def create
    @report = Report.new(params[:report])
    # totals = ReportTotal.new(@report)
    #     totals.create!
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
   end
  end
end