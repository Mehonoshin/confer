class BaseProjectController < ApplicationController
  layout "project"

  before_filter :preload_project
  helper_method :service_url, :conference_site_url

  private

    def conference_site_url(conference)
      url_for(controller: :main, host: request.host, subdomain: conference.domain)
    end

    def preload_project
      @conference = Conference.find_by_domain(request.subdomain)
    end

    def service_url
      request.domain
    end

end
