class Project::ConferencesController < Project::BaseProjectController

  def edit
  end

  def update
    @conference = Conference.find(params[:id])
    if @conference.update_attributes(params[:conference])
      redirect_to settings_path, notice: t('conference.notices.updated')
    else
      render :edit
    end
  end

end
