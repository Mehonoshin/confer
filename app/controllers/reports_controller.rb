class ReportsController < BaseProjectController
  load_and_authorize_resource

  def index
    @reports = @conference.reports#.with_state(:)
  end

end

