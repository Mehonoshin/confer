class Admin::ConferencesController < Admin::BaseController
  def index
    @conferences = Conference.order("start_date DESC")
  end

  def show
    @conference = Conference.find(params[:id])
    @audits = @conference.audits
  end

  def approve
    @conference = Conference.find(params[:id])
    @conference.approve!
    redirect_to admin_conferences_path, notice: t('admin.conferences.notices.approved')
  end

  def destroy
    Conference.find(params[:id]).destroy
    redirect_to admin_conferences_path, notice: t('admin.conferences.notices.removed')
  end

  def edit
    @conference = Conference.find(params[:id])
  end

  def update
    @conference = Conference.find(params[:id])
    @conference.update_attributes(params[:conference])
    redirect_to edit_admin_conference_path(@conference), notice: t('admin.conferences.notices.updated')
  end
end
