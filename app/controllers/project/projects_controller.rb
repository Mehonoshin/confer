class Project::ProjectsController < Project::BaseProjectController

  def index
    @page_title += " #{@conference.name}"
  end

  def settings
    
  end

end
