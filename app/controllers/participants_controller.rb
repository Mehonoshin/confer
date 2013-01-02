class ParticipantsController < BaseProjectController
  load_and_authorize_resource

  def index
    @participants = @conference.participants
  end

  def new
    @participant = Participant.new
    @participant.reports.build
  end

  def create
    attrs = params[:participant].dup
    attrs[:conference_id] = @conference.id
    attrs[:reports_attributes]["0"][:conference_id] = @conference.id
    current_user.participations.create!(attrs)
    redirect_to conference_site_url(@conference), notice: t('projects.participant.request_send')
  end

  def destroy
    Participant.find(params[:id]).destroy
    redirect_to participants_path, notice: t('projects.participants.destroyed')
  end

  def approve
    Participant.find(params[:id]).approve!
    redirect_to participants_path, notice: t('projects.participants.approved')
    authorize! :moderate, @conference
  end
end
