class Project::FeedbacksController < Project::BaseProjectController
  before_filter :authorize_project_management, except: [ :create, :new ]

  def index
    @feedbacks = @conference.feedbacks.order("id DESC")
  end

  def show
    @feedback = @conference.feedbacks.find(params[:id])
    @feedback.read! if @feedback.unread?
  end

  def new
    @feedback = Feedback.new
  end

  def create
    attrs = params[:feedback]
    attrs[:user_id] = current_user.id if signed_in?
    @feedback = @conference.feedbacks.create(attrs)
    if @feedback.valid?
      redirect_to contacts_path, notice: t('projects.feedbacks.notices.created')
    else
      render action: "new"
    end
  end

  def destroy
    @feedback = @conference.feedbacks.find(params[:id])
    @feedback.destroy
    redirect_to feedbacks_path, notice: t('projects.feedbacks.notices.removed')
  end
end
