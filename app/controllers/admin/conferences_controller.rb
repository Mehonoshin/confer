class Admin::ConferencesController < Admin::BaseController
  def index
    @conferences = Conference.order("start_date DESC")
  end

  def approve
    @conference = Conference.find(params[:id])
    @conference.approve!
    redirect_to admin_conferences_path
  end
end
