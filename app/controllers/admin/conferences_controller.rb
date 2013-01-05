class Admin::ConferencesController < Admin::BaseController
  def index
    @conferences = Conference.order("start_date DESC")
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
    
    Conference.find(params[:id]).update_attributes(params[:conference])
    redirect_to admin_conferences_path, notice: t('conferences.notices.updated')
  end
end
