class ReportsController < BaseProjectController
  load_and_authorize_resource

  def index
    @reports = @conference.reports
    @pending_reports_count = @conference.reports.with_state(:pending).size
    if can? :moderate, @conference
      render "index_admin"
    else
      render "index"
    end
  end

  def edit
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    @report.update_attributes(params[:report])
    redirect_to edit_report_path(@report), notice: t('projects.reports.notices.updated')
  end

  def destroy
    Report.find(params[:id]).destroy
    redirect_to reports_path, notice: t('projects.reports.notices.removed')
  end

  def approve
    Report.find(params[:id]).approve!
    redirect_to reports_path, notice: t('projects.reports.notices.approved')
    authorize! :moderate, @conference
  end

end

