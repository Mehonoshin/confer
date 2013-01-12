class BaseProjectController < ApplicationController
  layout "project"

  before_filter :preload_project
  before_filter :preload_participant, :preload_organizer
  helper_method :service_url, :conference_site_url

  private

    def authorize_project_management
      authorize! :moderate, @conference
    end

    def check_if_organizer
      redirect_to conference_site_url(@conference), notice: t('projects.news.notices.become_organizer') if @current_organizer.nil?
    end

    def conference_site_url(conference)
      url_for(controller: :main, host: request.host, subdomain: conference.domain)
    end

    def preload_project
      @conference = Conference.find_by_domain(request.subdomain)
    end

    def preload_participant
      @current_participant = @conference.participants.where(user_id: current_user.id).last if signed_in?
    end

    def preload_organizer
      @current_organizer = @conference.organizers.where(user_id: current_user.id).last if signed_in?
    end

    def service_url
      request.domain
    end

end
