class ProjectsController < BaseProjectController

  def index
    @page_title += " #{@conference.name}"
  end

end
