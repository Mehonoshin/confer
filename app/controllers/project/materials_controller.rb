class Project::MaterialsController < Project::BaseProjectController
  load_and_authorize_resource
  before_filter :preload_user_reports, only: [:new]

  def index
    @materials = Material.all
  end

  def new
    @material = Material.new
  end

  def create
    attrs = params[:material].dup
    attrs[:user_id] = current_user.id
    @material = @conference.materials.create(attrs)
    if @material.valid?
      redirect_to materials_path, notice: t('projects.materials.notices.created')
    else
      render :new
    end
  end

  def approve
    @material = Material.find(params[:id])
    @material.approve!
    redirect_to materials_path, notice: t('projects.materials.notices.approved')
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    redirect_to materials_path, notice: t('projects.materials.notices.removed')
  end

  private

    def preload_user_reports
      if @current_organizer
        @reports = @conference.reports.with_state(:approved)
      elsif @current_participant
        @reports = @conference.reports.with_state(:approved).where(participant_id: @current_participant.id)
      else
        @reports = []
      end
    end
end
