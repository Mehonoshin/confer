class BaseProjectController < ApplicationController
  layout "project"

  before_filter :preload_project
  helper_method :service_url

  private

    def preload_project
      @conference = Conference.find_by_domain(request.subdomain)
    end

    def service_url
      request.domain
    end

end
