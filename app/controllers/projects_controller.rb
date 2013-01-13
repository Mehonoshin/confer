class ProjectsController < BaseProjectController

  def index
    @page_title += " #{@conference.name}"
  end

  def contacts
    @feedback = Feedback.new
  end

end
