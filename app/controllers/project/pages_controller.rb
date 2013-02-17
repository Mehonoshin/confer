class Project::PagesController < Project::BaseProjectController
  #load_and_authorize_resource
  before_filter :verify_access, except: [:show]

  def index
    @pages = @conference.pages
  end

  def new
    @page = @conference.pages.new
  end

  def create
    @page = @conference.pages.create(params[:page])

    if @page.valid?
      redirect_to pages_path, notice: t('projects.pages.notices.created')
    else
      render "new"
    end
  end

  def update
    @page = @conference.pages.find_by_permalink(params[:id])
    @page.update_attributes(params[:page])
    if @page.valid?
      redirect_to pages_path, notice: t('projects.pages.notices.updated')
    else
      render "edit"
    end
  end

  def edit
    @page = @conference.pages.find_by_permalink(params[:id])
  end

  def destroy
    @page = @conference.pages.find_by_permalink(params[:id])
    @page.destroy
    redirect_to pages_path, notice: t('projects.pages.notices.removed')
  end

  def show
    @page = @conference.pages.find_by_permalink(params[:id])
    @page_title = @page.title
  end

  private

    def verify_access
      authorize! :manage, Page
    end

end
