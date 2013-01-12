class OrganizersController < BaseProjectController
  before_filter :authorize_project_management

  def index
    @organizers = @conference.organizers
  end

  def new
    @organizer = Organizer.new
  end

  def destroy
    @conference.organizers.find(params[:id]).destroy
    redirect_to organizers_path, notice: t('projects.organizers.notices.destroyed')
  end

  def create
    @organizer = @conference.organizers.create!(params[:organizer])
    redirect_to organizers_path, notice: t('projects.organizers.notices.created')
  end
end
