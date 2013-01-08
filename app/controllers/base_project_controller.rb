class BaseProjectController < ApplicationController
  layout "project"

  before_filter :preload_project
  before_filter :preload_participant
  helper_method :service_url, :conference_site_url

  private

    def conference_site_url(conference)
      url_for(controller: :main, host: request.host, subdomain: conference.domain)
    end

    def preload_project
      @conference = Conference.find_by_domain(request.subdomain)
    end

    def preload_participant
      @current_participant = @conference.participants.where(user_id: current_user.id).last if signed_in?
    end

    def service_url
      request.domain
    end

end
