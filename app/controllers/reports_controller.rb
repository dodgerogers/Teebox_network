class ReportsController < ApplicationController
  before_filter :authenticate_user! 
  before_filter :all_reports, except: [:create, :destroy]
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
    totals = GenerateReport.new(@report)
    totals.create
    if @report.save
      redirect_to reports_path, notice: "Report Created"
    else
     redirect_to reports_path, notice: "Report generation failed"
    end
  end 
  
  def destroy
    @report = Report.destroy(params[:id])
    if @report.destroy
     redirect_to stats_reports_path, notice: "Report deleted"
   end
  end
end