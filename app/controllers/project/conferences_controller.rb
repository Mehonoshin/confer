class Project::ConferencesController < Project::BaseProjectController
  before_filter :authorize_project_management

  def edit
  end

  def update
    @conference = Conference.find(params[:id])
    if @conference.update_attributes(params[:conference])
      redirect_to settings_path, notice: t('projects.conferences.notices.updated')
    else
      render :edit
    end
  end

end
